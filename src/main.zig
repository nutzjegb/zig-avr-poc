const std = @import("std");
const cpu = @import("AVR64EA48.zig").regs;

const BAUD_RATE = 115200;
const F_CPU = 20 * 1000000;

const PORTB_PIN_DEBUG_LED = 8;
const PORTC_PIN_USART_TX = 1;

fn clock_int_hf_init() void {
    // Disable the prescaler, the PDIV value is ignored
    // This should set the clock to 20Mhz
    cpu.CLKCTRL.MCLKCTRLB.write(.{ .PEN = 0, .PDIV = .DIV6 });
}

fn usart_init() void {
    const S = 16;
    const buadrate = (64 * F_CPU) / (S * BAUD_RATE);
    cpu.USART1.BAUD = buadrate;
    cpu.USART1.CTRLC.write(.{
        .CHSIZE = .@"8BIT",
        .SBMODE = .@"1BIT",
        .CMODE = .ASYNCHRONOUS,
        .PMODE = .ODD,
    });

    // Configure the TX pin as output
    cpu.PORTC.DIRSET = PORTC_PIN_USART_TX;

    // Enable USART
    cpu.USART1.CTRLB.write(.{
        .MPCM = 0,
        .RXMODE = .NORMAL,
        .ODME = 0,
        .SFDEN = 0,
        .TXEN = 1,
        .RXEN = 0,
    });
}

fn putstr(str: []const u8) void {
    for (str) |c| {
        while (cpu.USART1.STATUS.read().DREIF == 0) {}
        cpu.USART1.TXDATAL.write(.{ .DATA = c });
    }
}

export fn microzig_main() noreturn {
    main() catch |err| {
        _ = err;
    };
    while (true) {}
}

pub fn main() !void {
    cpu.PORTB.DIRSET = PORTB_PIN_DEBUG_LED;
    clock_int_hf_init();
    usart_init();

    // TODO: VPORT?

    putstr("Hello world!\n");

    var led_on = true;
    while (true) {
        if (led_on) {
            cpu.PORTB.OUTSET = PORTB_PIN_DEBUG_LED;
        } else {
            cpu.PORTB.OUTCLR = PORTB_PIN_DEBUG_LED;
        }
        busy_sleep(20_000);
        led_on = !led_on;
    }
}

fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be non-negative!");

    comptime var bits = 0;
    inline while ((1 << bits) <= limit) {
        bits += 1;
    }

    const I = std.meta.Int(.unsigned, bits);

    var i: I = 0;
    while (i < limit) : (i += 1) {
        std.mem.doNotOptimizeAway(i);
    }
}
