const mmio = @import("mmio.zig");

pub const FUSE = extern struct {
    /// BOD Operation in Active Mode select
    pub const FUSE_ACTIVE = enum(u2) {
        /// Disabled
        DISABLE = 0x0,
        /// Enabled in continuous mode
        ENABLED = 0x1,
        /// Enabled in sampled mode
        SAMPLED = 0x2,
        /// Enabled in continuous mode. Execution halted at wake-up until BOD is running
        ENABLEWAIT = 0x3,
    };

    /// CRC Select
    pub const FUSE_CRCSEL = enum(u1) {
        /// Enable CRC16
        CRC16 = 0x0,
        /// Enable CRC32
        CRC32 = 0x1,
    };

    /// CRC Source select
    pub const FUSE_CRCSRC = enum(u2) {
        /// CRC of full Flash (boot, application code and application data)
        FLASH = 0x0,
        /// CRC of boot section
        BOOT = 0x1,
        /// CRC of application code and boot sections
        BOOTAPP = 0x2,
        /// No CRC
        NOCRC = 0x3,
    };

    /// EEPROM Save select
    pub const FUSE_EESAVE = enum(u1) {
        /// EEPROM content is erased during chip erase
        DISABLE = 0x0,
        /// EEPROM content is preserved during chip erase
        ENABLE = 0x1,
    };

    /// BOD Level select
    pub const FUSE_LVL = enum(u3) {
        /// BOD Disabled during normal operation
        BODLEVEL0 = 0x0,
        /// 1.9 V
        BODLEVEL1 = 0x1,
        /// 2.7 V
        BODLEVEL2 = 0x2,
        /// 4.5 V
        BODLEVEL3 = 0x3,
        _,
    };

    /// High-frequency Oscillator Frequency select
    pub const FUSE_OSCHFFRQ = enum(u1) {
        /// OSCHF running at 20 MHz
        @"20M" = 0x0,
        /// OSCHF running at 16 MHz
        @"16M" = 0x1,
    };

    /// Watchdog Timeout Period select
    pub const FUSE_PERIOD = enum(u4) {
        /// Watch-Dog timer Off
        OFF = 0x0,
        /// 8 cycles (8ms)
        @"8CLK" = 0x1,
        /// 16 cycles (16ms)
        @"16CLK" = 0x2,
        /// 32 cycles (32ms)
        @"32CLK" = 0x3,
        /// 64 cycles (64ms)
        @"64CLK" = 0x4,
        /// 128 cycles (0.128s)
        @"128CLK" = 0x5,
        /// 256 cycles (0.256s)
        @"256CLK" = 0x6,
        /// 512 cycles (0.512s)
        @"512CLK" = 0x7,
        /// 1K cycles (1.0s)
        @"1KCLK" = 0x8,
        /// 2K cycles (2.0s)
        @"2KCLK" = 0x9,
        /// 4K cycles (4.0s)
        @"4KCLK" = 0xa,
        /// 8K cycles (8.0s)
        @"8KCLK" = 0xb,
        _,
    };

    /// Reset Pin Configuration select
    pub const FUSE_RSTPINCFG = enum(u1) {
        /// No External Reset
        NONE = 0x0,
        /// PF6 configured as RESET pin
        RESET = 0x1,
    };

    /// BOD Sample Frequency select
    pub const FUSE_SAMPFREQ = enum(u1) {
        /// Sampling frequency is 128 Hz
        @"128HZ" = 0x0,
        /// Sample frequency is 32 Hz
        @"32HZ" = 0x1,
    };

    /// BOD Operation in Sleep Mode select
    pub const FUSE_SLEEP = enum(u2) {
        /// Disabled
        DISABLE = 0x0,
        /// Enabled in continuous mode
        ENABLE = 0x1,
        /// Enabled in sampled mode
        SAMPLE = 0x2,
        _,
    };

    /// Startup Time select
    pub const FUSE_SUT = enum(u3) {
        /// 0 ms
        @"0MS" = 0x0,
        /// 1 ms
        @"1MS" = 0x1,
        /// 2 ms
        @"2MS" = 0x2,
        /// 4 ms
        @"4MS" = 0x3,
        /// 8 ms
        @"8MS" = 0x4,
        /// 16 ms
        @"16MS" = 0x5,
        /// 32 ms
        @"32MS" = 0x6,
        /// 64 ms
        @"64MS" = 0x7,
    };

    /// UPDI Pin Configuration select
    pub const FUSE_UPDIPINCFG = enum(u1) {
        /// PF7 Configured as GPIO pin
        GPIO = 0x0,
        /// PF7 Configured as UPDI pin
        UPDI = 0x1,
    };

    /// Watchdog Window Timeout Period select
    pub const FUSE_WINDOW = enum(u4) {
        /// Window mode off
        OFF = 0x0,
        /// 8 cycles (8ms)
        @"8CLK" = 0x1,
        /// 16 cycles (16ms)
        @"16CLK" = 0x2,
        /// 32 cycles (32ms)
        @"32CLK" = 0x3,
        /// 64 cycles (64ms)
        @"64CLK" = 0x4,
        /// 128 cycles (0.128s)
        @"128CLK" = 0x5,
        /// 256 cycles (0.256s)
        @"256CLK" = 0x6,
        /// 512 cycles (0.512s)
        @"512CLK" = 0x7,
        /// 1K cycles (1.0s)
        @"1KCLK" = 0x8,
        /// 2K cycles (2.0s)
        @"2KCLK" = 0x9,
        /// 4K cycles (4.0s)
        @"4KCLK" = 0xa,
        /// 8K cycles (8.0s)
        @"8KCLK" = 0xb,
        _,
    };

    /// Watchdog Configuration
    /// offset: 0x00
    WDTCFG: mmio.Mmio(packed struct(u8) {
        /// Watchdog Timeout Period
        PERIOD: FUSE_PERIOD,
        /// Watchdog Window Timeout Period
        WINDOW: FUSE_WINDOW,
    }),
    /// BOD Configuration
    /// offset: 0x01
    BODCFG: mmio.Mmio(packed struct(u8) {
        /// BOD Operation in Sleep Mode
        SLEEP: FUSE_SLEEP,
        /// BOD Operation in Active Mode
        ACTIVE: FUSE_ACTIVE,
        /// BOD Sample Frequency
        SAMPFREQ: FUSE_SAMPFREQ,
        /// BOD Level
        LVL: FUSE_LVL,
    }),
    /// Oscillator Configuration
    /// offset: 0x02
    OSCCFG: mmio.Mmio(packed struct(u8) {
        reserved3: u3 = 0,
        /// High-frequency Oscillator Frequency
        OSCHFFRQ: FUSE_OSCHFFRQ,
        padding: u4 = 0,
    }),
    /// offset: 0x03
    reserved3: [2]u8,
    /// System Configuration 0
    /// offset: 0x05
    SYSCFG0: mmio.Mmio(packed struct(u8) {
        /// EEPROM Save
        EESAVE: FUSE_EESAVE,
        reserved3: u2 = 0,
        /// Reset Pin Configuration
        RSTPINCFG: FUSE_RSTPINCFG,
        /// UPDI Pin Configuration
        UPDIPINCFG: FUSE_UPDIPINCFG,
        /// CRC Select
        CRCSEL: FUSE_CRCSEL,
        /// CRC Source
        CRCSRC: FUSE_CRCSRC,
    }),
    /// System Configuration 1
    /// offset: 0x06
    SYSCFG1: mmio.Mmio(packed struct(u8) {
        /// Startup Time
        SUT: FUSE_SUT,
        padding: u5 = 0,
    }),
    /// Code Section Size
    /// offset: 0x07
    CODESIZE: u8,
    /// Boot Section Size
    /// offset: 0x08
    BOOTSIZE: u8,
};
