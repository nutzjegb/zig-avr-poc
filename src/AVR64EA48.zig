// Generated with regz, see microzig repo
// Did add some convenience functions

const std = @import("std");
pub const peripherals = @import("peripherals.zig");

// Microzig uses a different approach here, so beware
pub const Handler = union(enum) {
    handler: fn () void,
    unhandled,
};
const unhandled: Handler = .{ .unhandled = {} };

// Modified from regz, the Reset vector is not a interrupt function
// and we only use this for interrupt registration
pub const VectorTable = struct {
    //RESET: Handler,
    CRCSCAN_NMI: Handler = unhandled,
    BOD_VLM: Handler = unhandled,
    CLKCTRL_CFD: Handler = unhandled,
    RTC_CNT: Handler = unhandled,
    RTC_PIT: Handler = unhandled,
    CCL_CCL: Handler = unhandled,
    PORTA_PORT: Handler = unhandled,
    TCA0_LUNF: Handler = unhandled,
    TCA0_HUNF: Handler = unhandled,
    TCA0_CMP0: Handler = unhandled,
    TCA0_CMP1: Handler = unhandled,
    TCA0_CMP2: Handler = unhandled,
    TCB0_INT: Handler = unhandled,
    TCB1_INT: Handler = unhandled,
    TWI0_TWIS: Handler = unhandled,
    TWI0_TWIM: Handler = unhandled,
    SPI0_INT: Handler = unhandled,
    USART0_RXC: Handler = unhandled,
    USART0_DRE: Handler = unhandled,
    USART0_TXC: Handler = unhandled,
    PORTD_PORT: Handler = unhandled,
    AC0_AC: Handler = unhandled,
    ADC0_ERROR: Handler = unhandled,
    ADC0_RESRDY: Handler = unhandled,
    ADC0_SAMPRDY: Handler = unhandled,
    AC1_AC: Handler = unhandled,
    PORTC_PORT: Handler = unhandled,
    TCB2_INT: Handler = unhandled,
    USART1_RXC: Handler = unhandled,
    USART1_DRE: Handler = unhandled,
    USART1_TXC: Handler = unhandled,
    PORTF_PORT: Handler = unhandled,
    NVMCTRL_EEREADY: Handler = unhandled,
    USART2_RXC: Handler = unhandled,
    USART2_DRE: Handler = unhandled,
    USART2_TXC: Handler = unhandled,
    TCB3_INT: Handler = unhandled,
    TCA1_LUNF: Handler = unhandled,
    TCA1_HUNF: Handler = unhandled,
    TCA1_CMP0: Handler = unhandled,
    TCA1_CMP1: Handler = unhandled,
    TCA1_CMP2: Handler = unhandled,
    PORTE_PORT: Handler = unhandled,
    PORTB_PORT: Handler = unhandled,
};

// Not used, so disabled
// (not needed as zig ignores unused code)
// pub const Interrupt = struct {
//     name: [:0]const u8,
//     index: i16,
// };
//
// (not needed as zig ignores unused code)
// pub const interrupts: []const Interrupt = &.{
//     .{ .name = "CRCSCAN_NMI", .index = 1 },
//     .{ .name = "BOD_VLM", .index = 2 },
//     .{ .name = "CLKCTRL_CFD", .index = 3 },
//     .{ .name = "RTC_CNT", .index = 4 },
//     .{ .name = "RTC_PIT", .index = 5 },
//     .{ .name = "CCL_CCL", .index = 6 },
//     .{ .name = "PORTA_PORT", .index = 7 },
//     .{ .name = "TCA0_LUNF", .index = 8 },
//     .{ .name = "TCA0_HUNF", .index = 9 },
//     .{ .name = "TCA0_CMP0", .index = 10 },
//     .{ .name = "TCA0_CMP1", .index = 11 },
//     .{ .name = "TCA0_CMP2", .index = 12 },
//     .{ .name = "TCB0_INT", .index = 13 },
//     .{ .name = "TCB1_INT", .index = 14 },
//     .{ .name = "TWI0_TWIS", .index = 15 },
//     .{ .name = "TWI0_TWIM", .index = 16 },
//     .{ .name = "SPI0_INT", .index = 17 },
//     .{ .name = "USART0_RXC", .index = 18 },
//     .{ .name = "USART0_DRE", .index = 19 },
//     .{ .name = "USART0_TXC", .index = 20 },
//     .{ .name = "PORTD_PORT", .index = 21 },
//     .{ .name = "AC0_AC", .index = 22 },
//     .{ .name = "ADC0_ERROR", .index = 23 },
//     .{ .name = "ADC0_RESRDY", .index = 24 },
//     .{ .name = "ADC0_SAMPRDY", .index = 25 },
//     .{ .name = "AC1_AC", .index = 26 },
//     .{ .name = "PORTC_PORT", .index = 27 },
//     .{ .name = "TCB2_INT", .index = 28 },
//     .{ .name = "USART1_RXC", .index = 29 },
//     .{ .name = "USART1_DRE", .index = 30 },
//     .{ .name = "USART1_TXC", .index = 31 },
//     .{ .name = "PORTF_PORT", .index = 32 },
//     .{ .name = "NVMCTRL_EEREADY", .index = 33 },
//     .{ .name = "USART2_RXC", .index = 34 },
//     .{ .name = "USART2_DRE", .index = 35 },
//     .{ .name = "USART2_TXC", .index = 36 },
//     .{ .name = "TCB3_INT", .index = 37 },
//     .{ .name = "TCA1_LUNF", .index = 38 },
//     .{ .name = "TCA1_HUNF", .index = 39 },
//     .{ .name = "TCA1_CMP0", .index = 40 },
//     .{ .name = "TCA1_CMP1", .index = 41 },
//     .{ .name = "TCA1_CMP2", .index = 42 },
//     .{ .name = "PORTE_PORT", .index = 43 },
//     .{ .name = "PORTB_PORT", .index = 44 },
// };

pub const regs = struct {
    pub const VPORTA: *volatile peripherals.VPORT = @ptrFromInt(0x0);
    pub const VPORTB: *volatile peripherals.VPORT = @ptrFromInt(0x4);
    pub const VPORTC: *volatile peripherals.VPORT = @ptrFromInt(0x8);
    pub const VPORTD: *volatile peripherals.VPORT = @ptrFromInt(0xc);
    pub const VPORTE: *volatile peripherals.VPORT = @ptrFromInt(0x10);
    pub const VPORTF: *volatile peripherals.VPORT = @ptrFromInt(0x14);
    pub const GPR: *volatile peripherals.GPR = @ptrFromInt(0x1c);
    pub const CPU: *volatile peripherals.CPU = @ptrFromInt(0x30);
    pub const RSTCTRL: *volatile peripherals.RSTCTRL = @ptrFromInt(0x40);
    pub const SLPCTRL: *volatile peripherals.SLPCTRL = @ptrFromInt(0x50);
    pub const CLKCTRL: *volatile peripherals.CLKCTRL = @ptrFromInt(0x60);
    pub const BOD: *volatile peripherals.BOD = @ptrFromInt(0xa0);
    pub const VREF: *volatile peripherals.VREF = @ptrFromInt(0xb0);
    pub const WDT: *volatile peripherals.WDT = @ptrFromInt(0x100);
    pub const CPUINT: *volatile peripherals.CPUINT = @ptrFromInt(0x110);
    pub const CRCSCAN: *volatile peripherals.CRCSCAN = @ptrFromInt(0x120);
    pub const RTC: *volatile peripherals.RTC = @ptrFromInt(0x140);
    pub const CCL: *volatile peripherals.CCL = @ptrFromInt(0x1c0);
    pub const EVSYS: *volatile peripherals.EVSYS = @ptrFromInt(0x200);
    pub const PORTA: *volatile peripherals.PORT = @ptrFromInt(0x400);
    pub const PORTB: *volatile peripherals.PORT = @ptrFromInt(0x420);
    pub const PORTC: *volatile peripherals.PORT = @ptrFromInt(0x440);
    pub const PORTD: *volatile peripherals.PORT = @ptrFromInt(0x460);
    pub const PORTE: *volatile peripherals.PORT = @ptrFromInt(0x480);
    pub const PORTF: *volatile peripherals.PORT = @ptrFromInt(0x4a0);
    pub const PORTMUX: *volatile peripherals.PORTMUX = @ptrFromInt(0x5e0);
    pub const ADC0: *volatile peripherals.ADC = @ptrFromInt(0x600);
    pub const AC0: *volatile peripherals.AC = @ptrFromInt(0x680);
    pub const AC1: *volatile peripherals.AC = @ptrFromInt(0x688);
    pub const DAC0: *volatile peripherals.DAC = @ptrFromInt(0x6a0);
    pub const USART0: *volatile peripherals.USART = @ptrFromInt(0x800);
    pub const USART1: *volatile peripherals.USART = @ptrFromInt(0x820);
    pub const USART2: *volatile peripherals.USART = @ptrFromInt(0x840);
    pub const TWI0: *volatile peripherals.TWI = @ptrFromInt(0x900);
    pub const SPI0: *volatile peripherals.SPI = @ptrFromInt(0x940);
    pub const TCA0: *volatile peripherals.TCA = @ptrFromInt(0xa00);
    pub const TCA1: *volatile peripherals.TCA = @ptrFromInt(0xa40);
    pub const TCB0: *volatile peripherals.TCB = @ptrFromInt(0xb00);
    pub const TCB1: *volatile peripherals.TCB = @ptrFromInt(0xb10);
    pub const TCB2: *volatile peripherals.TCB = @ptrFromInt(0xb20);
    pub const TCB3: *volatile peripherals.TCB = @ptrFromInt(0xb30);
    pub const SYSCFG: *volatile peripherals.SYSCFG = @ptrFromInt(0xf00);
    pub const NVMCTRL: *volatile peripherals.NVMCTRL = @ptrFromInt(0x1000);
    pub const LOCK: *volatile peripherals.LOCK = @ptrFromInt(0x1040);
    pub const FUSE: *volatile peripherals.FUSE = @ptrFromInt(0x1050);
    pub const USERROW: *volatile peripherals.USERROW = @ptrFromInt(0x1080);
    pub const SIGROW: *volatile peripherals.SIGROW = @ptrFromInt(0x1100);
};

pub fn enable_interrupts() void {
    asm volatile ("sei");
}

pub fn disable_interrupts() void {
    asm volatile ("cli");
}
