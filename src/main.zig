const std = @import("std");
const AVR64EA48 = @import("AVR64EA48.zig");
const chip = AVR64EA48.regs;

const BAUD_RATE = 115200;
const F_CPU = 20 * 1_000_000;

const PB3_LED0 = 8;
const PC0_USART_TX = 1;

const Delay = enum(usize) {
    DELAY_100 = 100,
    DELAY_250 = 250,
    DELAY_500 = 500,
    DELAY_1000 = 1000,
};
var current_delay = Delay.DELAY_1000;

// Pin Change Interrupt
fn portb_irq() void {
    current_delay = switch (current_delay) {
        .DELAY_100 => .DELAY_250,
        .DELAY_250 => .DELAY_500,
        .DELAY_500 => .DELAY_1000,
        .DELAY_1000 => .DELAY_100,
    };

    // Clear IRQ flags
    chip.PORTB.INTFLAGS.write(.{ .INT = 0xff });
}

// Register our interrupt so it ends up in the VectorTable
pub const interrupts: AVR64EA48.VectorTable = .{
    .PORTB_PORT = .{ .handler = portb_irq },
};

fn io_init() void {
    chip.PORTB.DIRSET = PB3_LED0;
}

fn clock_int_hf_init() void {
    // Disable the prescaler, the PDIV value is ignored
    // This should set the clock to 20Mhz
    chip.CPU.CCP.write(.{ .CCP = .IOREG });
    chip.CLKCTRL.MCLKCTRLB.write(.{ .PEN = 0, .PDIV = .DIV6 });
}

fn usart_init() void {
    const S = 16;
    const baudrate = (64 * F_CPU) / (S * BAUD_RATE);
    chip.USART1.BAUD = baudrate;
    chip.USART1.CTRLC.write(.{
        .CHSIZE = .@"8BIT",
        .SBMODE = .@"1BIT",
        .CMODE = .ASYNCHRONOUS,
        .PMODE = .ODD,
    });

    // Configure the TX pin as output
    chip.PORTC.DIRSET = PC0_USART_TX;

    // Enable USART
    chip.USART1.CTRLB.write(.{
        .MPCM = 0,
        .RXMODE = .NORMAL,
        .ODME = 0,
        .SFDEN = 0,
        .TXEN = 1,
        .RXEN = 0,
    });
}

pub fn putstr(str: []const u8) void {
    for (str) |c| {
        while (chip.USART1.STATUS.read().DREIF == 0) {}
        chip.USART1.TXDATAL.write(.{ .DATA = c });
    }
}

pub fn main() noreturn {
    clock_int_hf_init();
    io_init();
    usart_init();

    putstr("Hello world!\n");

    // Enable PIN irq
    chip.PORTB.INTFLAGS.write(.{ .INT = 0xff });
    chip.PORTB.PIN2CTRL.write(.{
        .PULLUPEN = 1,
        .ISC = .RISING,
        .INLVL = .ST,
        .INVEN = 0,
    });
    AVR64EA48.enable_interrupts();

    var led_on = true;
    while (true) {
        if (led_on) {
            chip.PORTB.OUTSET = PB3_LED0;
        } else {
            chip.PORTB.OUTCLR = PB3_LED0;
        }
        led_on = !led_on;

        putstr("delay ");
        putstr(switch (current_delay) {
            .DELAY_100 => "100",
            .DELAY_250 => "250",
            .DELAY_500 => "500",
            .DELAY_1000 => "1000",
        });
        putstr("\n");
        for (0..@intFromEnum(current_delay)) |_| {
            delay_1ms();
        }
    }
}

fn delay_1ms() void {
    // Ugly but works..
    for (0..1800) |_| {
        asm volatile (
            \\ nop
            \\ nop
            \\ nop
            \\ nop
        );
    }
}
