const mmio = @import("mmio.zig");

pub const CLKCTRL = extern struct {
    /// Automatic Oscillator Tune select
    pub const CLKCTRL_AUTOTUNE = enum(u2) {
        /// Disabled
        OFF = 0x0,
        /// Tune against 32.768 kHz Crystal Oscillator
        XOSC32K = 0x1,
        _,
    };

    /// CFD Source select
    pub const CLKCTRL_CFDSRC = enum(u2) {
        /// Main Clock
        CLKMAIN = 0x0,
        /// High Frequency Crystal Oscillator
        XOSCHF = 0x1,
        /// 32.768 kHz Crystal Oscillator
        XOSC32K = 0x2,
        _,
    };

    /// Clock select
    pub const CLKCTRL_CLKSEL = enum(u3) {
        /// Internal high-frequency oscillator
        OSCHF = 0x0,
        /// Internal 32.768 kHz oscillator
        OSC32K = 0x1,
        /// 32.768 kHz crystal oscillator
        XOSC32K = 0x2,
        /// External clock
        EXTCLK = 0x3,
        _,
    };

    /// Crystal startup time select
    pub const CLKCTRL_CSUT = enum(u2) {
        /// 1k cycles
        @"1K" = 0x0,
        /// 16k cycles
        @"16K" = 0x1,
        /// 32k cycles
        @"32K" = 0x2,
        /// 64k cycles
        @"64K" = 0x3,
    };

    /// Start-Up Time select
    pub const CLKCTRL_CSUTHF = enum(u2) {
        /// 256 XOSCHF Cycles
        @"256CYC" = 0x0,
        /// 1K XOSCHF Cycles
        @"1KCYC" = 0x1,
        /// 4K XOSCHF Cycles
        @"4KCYC" = 0x2,
        _,
    };

    /// Interrupt Type select
    pub const CLKCTRL_INTTYPE = enum(u1) {
        /// Regular interrupt
        INT = 0x0,
        /// Non-maskable interrupt
        NMI = 0x1,
    };

    /// Prescaler division select
    pub const CLKCTRL_PDIV = enum(u4) {
        /// Divide by 2
        DIV2 = 0x0,
        /// Divide by 4
        DIV4 = 0x1,
        /// Divide by 8
        DIV8 = 0x2,
        /// Divide by 16
        DIV16 = 0x3,
        /// Divide by 32
        DIV32 = 0x4,
        /// Divide by 64
        DIV64 = 0x5,
        /// Divide by 6
        DIV6 = 0x8,
        /// Divide by 10
        DIV10 = 0x9,
        /// Divide by 12
        DIV12 = 0xa,
        /// Divide by 24
        DIV24 = 0xb,
        /// Divide by 48
        DIV48 = 0xc,
        _,
    };

    /// Source Select
    pub const CLKCTRL_SELHF = enum(u1) {
        /// External Crystal
        CRYSTAL = 0x0,
        /// Extenal Clock on XTALHF1 pin
        EXTCLK = 0x1,
    };

    /// MCLK Control A
    /// offset: 0x00
    MCLKCTRLA: mmio.Mmio(packed struct(u8) {
        /// Clock select
        CLKSEL: CLKCTRL_CLKSEL,
        reserved7: u4 = 0,
        /// System clock out
        CLKOUT: u1,
    }),
    /// MCLK Control B
    /// offset: 0x01
    MCLKCTRLB: mmio.Mmio(packed struct(u8) {
        /// Prescaler enable
        PEN: u1,
        /// Prescaler division
        PDIV: CLKCTRL_PDIV,
        padding: u3 = 0,
    }),
    /// MCLK Control C
    /// offset: 0x02
    MCLKCTRLC: mmio.Mmio(packed struct(u8) {
        /// Clock Failure Detect Enable
        CFDEN: u1,
        /// CFD Test
        CFDTST: u1,
        /// CFD Source
        CFDSRC: CLKCTRL_CFDSRC,
        padding: u4 = 0,
    }),
    /// MCLK Interrupt Control
    /// offset: 0x03
    MCLKINTCTRL: mmio.Mmio(packed struct(u8) {
        /// Interrupt Enable
        CFD: u1,
        reserved7: u6 = 0,
        /// Interrupt Type
        INTTYPE: CLKCTRL_INTTYPE,
    }),
    /// MCLK Interrupt Flags
    /// offset: 0x04
    MCLKINTFLAGS: mmio.Mmio(packed struct(u8) {
        /// Clock Failure Detected
        CFD: u1,
        padding: u7 = 0,
    }),
    /// MCLK Status
    /// offset: 0x05
    MCLKSTATUS: mmio.Mmio(packed struct(u8) {
        /// System Oscillator changing
        SOSC: u1,
        /// High frequency oscillator status
        OSCHFS: u1,
        /// 32KHz oscillator status
        OSC32KS: u1,
        /// 32.768 kHz Crystal Oscillator status
        XOSC32KS: u1,
        /// External Clock status / XOSCHF status
        EXTS: u1,
        padding: u3 = 0,
    }),
    /// MCLK Timebase
    /// offset: 0x06
    MCLKTIMEBASE: mmio.Mmio(packed struct(u8) {
        /// Timebase
        TIMEBASE: u5,
        padding: u3 = 0,
    }),
    /// offset: 0x07
    reserved7: [1]u8,
    /// OSCHF Control A
    /// offset: 0x08
    OSCHFCTRLA: mmio.Mmio(packed struct(u8) {
        /// Automatic Oscillator Tune
        AUTOTUNE: CLKCTRL_AUTOTUNE,
        reserved7: u5 = 0,
        /// Run in standby
        RUNSTDBY: u1,
    }),
    /// OSCHF Tune
    /// offset: 0x09
    OSCHFTUNE: mmio.Mmio(packed struct(u8) {
        /// Oscillator Tune
        TUNE: u8,
    }),
    /// offset: 0x0a
    reserved10: [14]u8,
    /// OSC32K Control A
    /// offset: 0x18
    OSC32KCTRLA: mmio.Mmio(packed struct(u8) {
        reserved7: u7 = 0,
        /// Run standby
        RUNSTDBY: u1,
    }),
    /// offset: 0x19
    reserved25: [3]u8,
    /// XOSC32K Control A
    /// offset: 0x1c
    XOSC32KCTRLA: mmio.Mmio(packed struct(u8) {
        /// Enable
        ENABLE: u1,
        /// Low power mode
        LPMODE: u1,
        /// Select
        SEL: u1,
        reserved4: u1 = 0,
        /// Crystal startup time
        CSUT: CLKCTRL_CSUT,
        reserved7: u1 = 0,
        /// Run standby
        RUNSTDBY: u1,
    }),
    /// offset: 0x1d
    reserved29: [3]u8,
    /// XOSCHF Control A
    /// offset: 0x20
    XOSCHFCTRLA: mmio.Mmio(packed struct(u8) {
        /// Enable
        ENABLE: u1,
        /// Source Select
        SELHF: CLKCTRL_SELHF,
        reserved4: u2 = 0,
        /// Start-Up Time
        CSUTHF: CLKCTRL_CSUTHF,
        reserved7: u1 = 0,
        /// Run in Standby
        RUNSTDBY: u1,
    }),
};
