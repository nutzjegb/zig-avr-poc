const mmio = @import("mmio.zig");

pub const ADC = extern struct {
    /// Sign Chopping select
    pub const ADC_CHOPPING = enum(u1) {
        /// Sign Chopping Disabled
        DISABLE = 0x0,
        /// Sign Chopping Enabled
        ENABLE = 0x1,
    };

    /// Gain select
    pub const ADC_GAIN = enum(u3) {
        /// 1x gain
        @"1X" = 0x0,
        /// 2x gain
        @"2X" = 0x1,
        /// 4x gain
        @"4X" = 0x2,
        /// 8x gain
        @"8X" = 0x3,
        /// 16x gain
        @"16X" = 0x4,
        _,
    };

    /// Mode select
    pub const ADC_MODE = enum(u3) {
        /// Single Conversion with 8-bit resolution
        SINGLE_8BIT = 0x0,
        /// Single Conversion with 12-bit resolution
        SINGLE_12BIT = 0x1,
        /// Series with accumulation, separate trigger for every 12-bit conversion
        SERIES = 0x2,
        /// Series with accumulation and scaling, separate trigger for every 12-bit conversion
        SERIES_SCALING = 0x3,
        /// Burst with accumulation, one trigger will run SAMPNUM 12-bit conversions
        BURST = 0x4,
        /// Burst with accumulation and scaling, one trigger will run SAMPNUM 12-bit conversions
        BURST_SCALING = 0x5,
        _,
    };

    /// Analog Channel Selection Bits
    pub const ADC_MUXNEG = enum(u6) {
        /// ADC input pin 0
        AIN0 = 0x0,
        /// ADC input pin 1
        AIN1 = 0x1,
        /// ADC input pin 2
        AIN2 = 0x2,
        /// ADC input pin 3
        AIN3 = 0x3,
        /// ADC input pin 4
        AIN4 = 0x4,
        /// ADC input pin 5
        AIN5 = 0x5,
        /// ADC input pin 6
        AIN6 = 0x6,
        /// ADC input pin 7
        AIN7 = 0x7,
        /// ADC input pin 8
        AIN8 = 0x8,
        /// ADC input pin 9
        AIN9 = 0x9,
        /// ADC input pin 10
        AIN10 = 0xa,
        /// ADC input pin 11
        AIN11 = 0xb,
        /// ADC input pin 16
        AIN16 = 0x10,
        /// ADC input pin 17
        AIN17 = 0x11,
        /// ADC input pin 18
        AIN18 = 0x12,
        /// ADC input pin 19
        AIN19 = 0x13,
        /// ADC input pin 20
        AIN20 = 0x14,
        /// ADC input pin 21
        AIN21 = 0x15,
        /// ADC input pin 22
        AIN22 = 0x16,
        /// ADC input pin 23
        AIN23 = 0x17,
        /// ADC input pin 24
        AIN24 = 0x18,
        /// ADC input pin 25
        AIN25 = 0x19,
        /// ADC input pin 26
        AIN26 = 0x1a,
        /// ADC input pin 27
        AIN27 = 0x1b,
        /// ADC input pin 28
        AIN28 = 0x1c,
        /// ADC input pin 29
        AIN29 = 0x1d,
        /// ADC input pin 30
        AIN30 = 0x1e,
        /// ADC input pin 31
        AIN31 = 0x1f,
        /// Ground
        GND = 0x30,
        /// Digital to Analog Converter 0
        DAC0 = 0x38,
        /// AC0 DAC reference
        DACREF0 = 0x39,
        /// AC1 DAC reference
        DACREF1 = 0x3a,
        _,
    };

    /// Analog Channel Selection Bits
    pub const ADC_MUXPOS = enum(u6) {
        /// ADC input pin 0
        AIN0 = 0x0,
        /// ADC input pin 1
        AIN1 = 0x1,
        /// ADC input pin 2
        AIN2 = 0x2,
        /// ADC input pin 3
        AIN3 = 0x3,
        /// ADC input pin 4
        AIN4 = 0x4,
        /// ADC input pin 5
        AIN5 = 0x5,
        /// ADC input pin 6
        AIN6 = 0x6,
        /// ADC input pin 7
        AIN7 = 0x7,
        /// ADC input pin 8
        AIN8 = 0x8,
        /// ADC input pin 9
        AIN9 = 0x9,
        /// ADC input pin 10
        AIN10 = 0xa,
        /// ADC input pin 11
        AIN11 = 0xb,
        /// ADC input pin 16
        AIN16 = 0x10,
        /// ADC input pin 17
        AIN17 = 0x11,
        /// ADC input pin 18
        AIN18 = 0x12,
        /// ADC input pin 19
        AIN19 = 0x13,
        /// ADC input pin 20
        AIN20 = 0x14,
        /// ADC input pin 21
        AIN21 = 0x15,
        /// ADC input pin 22
        AIN22 = 0x16,
        /// ADC input pin 23
        AIN23 = 0x17,
        /// ADC input pin 24
        AIN24 = 0x18,
        /// ADC input pin 25
        AIN25 = 0x19,
        /// ADC input pin 26
        AIN26 = 0x1a,
        /// ADC input pin 27
        AIN27 = 0x1b,
        /// ADC input pin 28
        AIN28 = 0x1c,
        /// ADC input pin 29
        AIN29 = 0x1d,
        /// ADC input pin 30
        AIN30 = 0x1e,
        /// ADC input pin 31
        AIN31 = 0x1f,
        /// Ground
        GND = 0x30,
        /// VDD Divided by 10
        VDD10 = 0x31,
        /// Temperature Sensor
        TEMPSENSE = 0x32,
        /// Digital to Analog Converter 0
        DAC0 = 0x38,
        _,
    };

    /// PGA BIAS Select
    pub const ADC_PGABIASSEL = enum(u2) {
        /// 100% BIAS current.
        @"100PCT" = 0x0,
        /// 75% BIAS current. Usable for CLK_ADC<4.5MHz
        @"75PCT" = 0x1,
        /// 50% BIAS current. Usable for CLK_ADC<3MHz
        @"50PCT" = 0x2,
        /// 25% BIAS current. Usable for CLK_ADC<1.5MHz
        @"25PCT" = 0x3,
    };

    /// Prescaler Value select
    pub const ADC_PRESC = enum(u4) {
        /// System clock divided by 2
        DIV2 = 0x0,
        /// System clock divided by 4
        DIV4 = 0x1,
        /// System clock divided by 6
        DIV6 = 0x2,
        /// System clock divided by 8
        DIV8 = 0x3,
        /// System clock divided by 10
        DIV10 = 0x4,
        /// System clock divided by 12
        DIV12 = 0x5,
        /// System clock divided by 14
        DIV14 = 0x6,
        /// System clock divided by 16
        DIV16 = 0x7,
        /// System clock divided by 20
        DIV20 = 0x8,
        /// System clock divided by 24
        DIV24 = 0x9,
        /// System clock divided by 28
        DIV28 = 0xa,
        /// System clock divided by 32
        DIV32 = 0xb,
        /// System clock divided by 40
        DIV40 = 0xc,
        /// System clock divided by 48
        DIV48 = 0xd,
        /// System clock divided by 56
        DIV56 = 0xe,
        /// System clock divided by 64
        DIV64 = 0xf,
    };

    /// Reference select
    pub const ADC_REFSEL = enum(u3) {
        /// VDD
        VDD = 0x0,
        /// External Reference
        VREFA = 0x2,
        /// Internal 1.024V Reference
        @"1V024" = 0x4,
        /// Internal 2.048V Reference
        @"2V048" = 0x5,
        /// Internal 4.096V Reference
        @"4V096" = 0x6,
        /// Internal 2.500V Reference
        @"2V500" = 0x7,
        _,
    };

    /// Sample numbers select
    pub const ADC_SAMPNUM = enum(u4) {
        /// No accumulation
        NONE = 0x0,
        /// 2 samples accumulated
        ACC2 = 0x1,
        /// 4 samples accumulated
        ACC4 = 0x2,
        /// 8 samples accumulated
        ACC8 = 0x3,
        /// 16 samples accumulated
        ACC16 = 0x4,
        /// 32 samples accumulated
        ACC32 = 0x5,
        /// 64 samples accumulated
        ACC64 = 0x6,
        /// 128 samples accumulated
        ACC128 = 0x7,
        /// 256 samples accumulated
        ACC256 = 0x8,
        /// 512 samples accumulated
        ACC512 = 0x9,
        /// 1024 samples accumulated
        ACC1024 = 0xa,
        _,
    };

    /// Start command select
    pub const ADC_START = enum(u3) {
        /// Stop an ongoing conversion
        STOP = 0x0,
        /// Start a conversion immediately. This will be set back to STOP when the first conversion is done, unless Free-Running mode is enabled
        IMMEDIATE = 0x1,
        /// Start when MUXPOS register is written
        MUXPOS_WRITE = 0x2,
        /// Start when MUXNEG register is written
        MUXNEG_WRITE = 0x3,
        /// Start when an event is received
        EVENT_TRIGGER = 0x4,
        _,
    };

    /// VIA select
    pub const ADC_VIA = enum(u2) {
        /// Inputs connected directly to ADC
        DIRECT = 0x0,
        /// Inputs connected via PGA
        PGA = 0x1,
        _,
    };

    /// Window Comparator Mode select
    pub const ADC_WINCM = enum(u3) {
        /// No Window Comparison
        NONE = 0x0,
        /// Below Window
        BELOW = 0x1,
        /// Above Window
        ABOVE = 0x2,
        /// Inside Window
        INSIDE = 0x3,
        /// Outside Window
        OUTSIDE = 0x4,
        _,
    };

    /// Window Mode Source select
    pub const ADC_WINSRC = enum(u1) {
        /// Result register used as Window Comparator Source
        RESULT = 0x0,
        /// Sample register used as Window Comparator Source
        SAMPLE = 0x1,
    };

    /// Control A
    /// offset: 0x00
    CTRLA: mmio.Mmio(packed struct(u8) {
        /// ADC Enable
        ENABLE: u1,
        reserved5: u4 = 0,
        /// Low Latency
        LOWLAT: u1,
        reserved7: u1 = 0,
        /// Run in Standby
        RUNSTDBY: u1,
    }),
    /// Control B
    /// offset: 0x01
    CTRLB: mmio.Mmio(packed struct(u8) {
        /// Prescaler Value
        PRESC: ADC_PRESC,
        padding: u4 = 0,
    }),
    /// Control C
    /// offset: 0x02
    CTRLC: mmio.Mmio(packed struct(u8) {
        /// Reference select
        REFSEL: ADC_REFSEL,
        padding: u5 = 0,
    }),
    /// Control D
    /// offset: 0x03
    CTRLD: mmio.Mmio(packed struct(u8) {
        /// Window Comparator Mode
        WINCM: ADC_WINCM,
        /// Window Mode Source
        WINSRC: ADC_WINSRC,
        padding: u4 = 0,
    }),
    /// Interrupt Control
    /// offset: 0x04
    INTCTRL: mmio.Mmio(packed struct(u8) {
        /// Result Ready Interrupt Enable
        RESRDY: u1,
        /// Sample Ready Interrupt Enable
        SAMPRDY: u1,
        /// Window Comparator Interrupt Enable
        WCMP: u1,
        /// Result Overwrite Interrupt Enable
        RESOVR: u1,
        /// Sample Overwrite Interrupt Enable
        SAMPOVR: u1,
        /// Trigger Overrun Interrupt Enable
        TRIGOVR: u1,
        padding: u2 = 0,
    }),
    /// Interrupt Flags
    /// offset: 0x05
    INTFLAGS: mmio.Mmio(packed struct(u8) {
        /// Result Ready Interrupt Flag
        RESRDY: u1,
        /// Sample Ready Interrupt Flag
        SAMPRDY: u1,
        /// Window Comparator Interrupt Flag
        WCMP: u1,
        /// Result Overwrite Interrupt Flag
        RESOVR: u1,
        /// Sample Overwrite Interrupt Flag
        SAMPOVR: u1,
        /// Trigger Overrun Interrupt Flag
        TRIGOVR: u1,
        padding: u2 = 0,
    }),
    /// Status register
    /// offset: 0x06
    STATUS: mmio.Mmio(packed struct(u8) {
        /// ADC Busy
        ADCBUSY: u1,
        padding: u7 = 0,
    }),
    /// Debug Control
    /// offset: 0x07
    DBGCTRL: mmio.Mmio(packed struct(u8) {
        /// Run in Debug Mode
        DBGRUN: u1,
        padding: u7 = 0,
    }),
    /// Control E
    /// offset: 0x08
    CTRLE: mmio.Mmio(packed struct(u8) {
        /// Sample Duration
        SAMPDUR: u8,
    }),
    /// Control F
    /// offset: 0x09
    CTRLF: mmio.Mmio(packed struct(u8) {
        /// Sample numbers
        SAMPNUM: ADC_SAMPNUM,
        /// Left Adjust
        LEFTADJ: u1,
        /// Free-Running mode
        FREERUN: u1,
        /// Sign Chopping
        CHOPPING: ADC_CHOPPING,
        padding: u1 = 0,
    }),
    /// Command register
    /// offset: 0x0a
    COMMAND: mmio.Mmio(packed struct(u8) {
        /// Start command
        START: ADC_START,
        reserved4: u1 = 0,
        /// Mode
        MODE: ADC_MODE,
        /// Differential mode
        DIFF: u1,
    }),
    /// PGA Control
    /// offset: 0x0b
    PGACTRL: mmio.Mmio(packed struct(u8) {
        /// PGA Enable
        PGAEN: u1,
        reserved3: u2 = 0,
        /// PGA BIAS Select
        PGABIASSEL: ADC_PGABIASSEL,
        /// Gain
        GAIN: ADC_GAIN,
    }),
    /// Positive Input Multiplexer
    /// offset: 0x0c
    MUXPOS: mmio.Mmio(packed struct(u8) {
        /// Analog Channel Selection Bits
        MUXPOS: ADC_MUXPOS,
        /// VIA
        VIA: ADC_VIA,
    }),
    /// Negative Input Multiplexer
    /// offset: 0x0d
    MUXNEG: mmio.Mmio(packed struct(u8) {
        /// Analog Channel Selection Bits
        MUXNEG: ADC_MUXNEG,
        /// VIA
        VIA: ADC_VIA,
    }),
    /// offset: 0x0e
    reserved14: [2]u8,
    /// Result
    /// offset: 0x10
    RESULT: u32,
    /// Sample
    /// offset: 0x14
    SAMPLE: u16,
    /// offset: 0x16
    reserved22: [2]u8,
    /// Temporary Data 0
    /// offset: 0x18
    TEMP0: u8,
    /// Temporary Data 1
    /// offset: 0x19
    TEMP1: u8,
    /// Temporary Data 2
    /// offset: 0x1a
    TEMP2: u8,
    /// offset: 0x1b
    reserved27: [1]u8,
    /// Window Low Threshold
    /// offset: 0x1c
    WINLT: u16,
    /// Window High Threshold
    /// offset: 0x1e
    WINHT: u16,
};
