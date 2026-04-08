const std = @import("std");
const chip = @import("AVR64EA48.zig").regs;

const BAUD_RATE = 115200;
const F_CPU = 20 * 1_000_000;

const PB3_LED0 = 8;
const PC0_USART_TX = 1;

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

    // TODO: VPORT?

    putstr("Hello world!\n");

    var led_on = true;
    while (true) {
        if (led_on) {
            chip.PORTB.OUTSET = PB3_LED0;
        } else {
            chip.PORTB.OUTCLR = PB3_LED0;
        }

        putstr("delay...\n");
        for (0..1000) |_| {
            delay_1ms();
        }

        led_on = !led_on;
    }
}

fn delay_1ms() void {
    for (0..1800) |_| {
        asm volatile (
            \\ nop
            \\ nop
            \\ nop
            \\ nop
        );
    }
}
