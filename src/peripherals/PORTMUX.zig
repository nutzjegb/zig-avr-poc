const mmio = @import("mmio.zig");

pub const PORTMUX = extern struct {
    /// Analog Comparator 0 Output select
    pub const PORTMUX_AC0 = enum(u1) {
        /// OUT: PA7
        DEFAULT = 0x0,
        /// OUT: PC6
        ALT1 = 0x1,
    };

    /// Analog Comparator 1 Output select
    pub const PORTMUX_AC1 = enum(u1) {
        /// OUT: PA7
        DEFAULT = 0x0,
        /// OUT: PC6
        ALT1 = 0x1,
    };

    /// Event Output A select
    pub const PORTMUX_EVOUTA = enum(u1) {
        /// EVOUTA: PA2
        DEFAULT = 0x0,
        /// EVOUTA: PA7
        ALT1 = 0x1,
    };

    /// Event Output B select
    pub const PORTMUX_EVOUTB = enum(u1) {
        /// EVOUTB: PB2
        DEFAULT = 0x0,
        _,
    };

    /// Event Output C select
    pub const PORTMUX_EVOUTC = enum(u1) {
        /// EVOUTC: PC2
        DEFAULT = 0x0,
        /// EVOUTC: PC7
        ALT1 = 0x1,
    };

    /// Event Output D select
    pub const PORTMUX_EVOUTD = enum(u1) {
        /// EVOUTD: PD2
        DEFAULT = 0x0,
        /// EVOUTD: PD7
        ALT1 = 0x1,
    };

    /// Event Output E select
    pub const PORTMUX_EVOUTE = enum(u1) {
        /// EVOUTE: PE2
        DEFAULT = 0x0,
        _,
    };

    /// Event Output F select
    pub const PORTMUX_EVOUTF = enum(u1) {
        /// EVOUTF: PF2
        DEFAULT = 0x0,
        /// EVOUTF: PF7
        ALT1 = 0x1,
    };

    /// CCL Look-Up Table 0 Signals select
    pub const PORTMUX_LUT0 = enum(u1) {
        /// In: PA0, PA1, PA2, Out: PA3
        DEFAULT = 0x0,
        /// In: PA0, PA1, PA2, Out: PA6
        ALT1 = 0x1,
    };

    /// CCL Look-Up Table 1 Signals select
    pub const PORTMUX_LUT1 = enum(u1) {
        /// In: PC0, PC1, PC2, Out: PC3
        DEFAULT = 0x0,
        /// In: PC0, PC1, PC2, Out: PC6
        ALT1 = 0x1,
    };

    /// CCL Look-Up Table 2 Signals select
    pub const PORTMUX_LUT2 = enum(u1) {
        /// In: PD0, PD1, PD2, Out: PD3
        DEFAULT = 0x0,
        /// In: PD0, PD1, PD2, Out: PD6
        ALT1 = 0x1,
    };

    /// SPI0 Signals select
    pub const PORTMUX_SPI0 = enum(u3) {
        /// MOSI: PA4, MISO: PA5, SCK: PA6, SS: PA7
        DEFAULT = 0x0,
        /// MOSI: PE0, MISO: PE1, SCK: PE2, SS: PE3
        ALT1 = 0x1,
        /// MOSI: PA0, MISO: PA1, SCK: PC0, SS: PC1
        ALT3 = 0x3,
        /// MOSI: PD4, MISO: PD5, SCK: PD6, SS: PD7
        ALT4 = 0x4,
        /// MOSI: PC0, MISO: PC1, SCK: PC2, SS: PC3
        ALT5 = 0x5,
        /// MOSI: PC1, MISO: PC2, SCK: PC3, SS: PF7
        ALT6 = 0x6,
        /// Not connected to any pins, SS set to 1
        NONE = 0x7,
        _,
    };

    /// TCA0 Signals select
    pub const PORTMUX_TCA0 = enum(u3) {
        /// WOn: PA0, PA1, PA2, PA3, PA4, PA5
        PORTA = 0x0,
        /// WOn: PB0, PB1, PB2, PB3, PB4, PB5
        PORTB = 0x1,
        /// WOn: PC0, PC1, PC2, PC3, PC4, PC5
        PORTC = 0x2,
        /// WOn: PD0, PD1, PD2, PD3, PD4, PD5
        PORTD = 0x3,
        /// WOn: PE0, PE1, PE2, PE3, -, -
        PORTE = 0x4,
        /// WOn: PF0, PF1, PF2, PF3, PF4, PF5
        PORTF = 0x5,
        _,
    };

    /// TCA1 Signals select
    pub const PORTMUX_TCA1 = enum(u3) {
        /// WOn: PB0, PB1, PB2, PB3, PB4, PB5
        PORTB = 0x0,
        /// WOn: PC4, PC5, PC6, -, -, -
        PORTC = 0x1,
        /// WOn: PA4, PA5, PA6, -, -, -
        PORTA = 0x4,
        /// WOn: PD4, PD5, PD6, -, -, -
        PORTD = 0x5,
        _,
    };

    /// TCB0 Output select
    pub const PORTMUX_TCB0 = enum(u1) {
        /// WO: PA2
        DEFAULT = 0x0,
        /// WO: PF4
        ALT1 = 0x1,
    };

    /// TCB1 Output select
    pub const PORTMUX_TCB1 = enum(u1) {
        /// WO: PA3
        DEFAULT = 0x0,
        /// WO: PF5
        ALT1 = 0x1,
    };

    /// TCB2 Output select
    pub const PORTMUX_TCB2 = enum(u1) {
        /// WO: PC0
        DEFAULT = 0x0,
        /// WO: PB4
        ALT1 = 0x1,
    };

    /// TCB3 Output select
    pub const PORTMUX_TCB3 = enum(u1) {
        /// WO: PB5
        DEFAULT = 0x0,
        /// WO: PC1
        ALT1 = 0x1,
    };

    /// TWI0 Signals select
    pub const PORTMUX_TWI0 = enum(u2) {
        /// SDA: PA2, SCL: PA3. Dual mode: SDA: PC2, SCL: PC3
        DEFAULT = 0x0,
        /// SDA: PA2, SCL: PA3. Dual mode: SDA: PC6, SCL: PC7
        ALT1 = 0x1,
        /// SDA: PC2, SCL: PC3. Dual mode: SDA: PC6, SCL: PC7
        ALT2 = 0x2,
        /// SDA: PA0, SCL: PA1. Dual mode: SDA: PC2, SCL: PC3
        ALT3 = 0x3,
    };

    /// USART0 Routing select
    pub const PORTMUX_USART0 = enum(u3) {
        /// TxD: PA0, RxD: PA1, XCK: PA2, XDIR: PA3
        DEFAULT = 0x0,
        /// TxD: PA4, RxD: PA5, XCK: PA6, XDIR: PA7
        ALT1 = 0x1,
        /// TxD: PA2, RxD: PA3, XCK: -, XDIR: -
        ALT2 = 0x2,
        /// TxD: PD4, RxD: PD5, XCK: PD6, XDIR: PD7
        ALT3 = 0x3,
        /// TxD: PC1, RxD: PC2, XCK: PC3, XDIR: -
        ALT4 = 0x4,
        /// Not connected to any pins
        NONE = 0x5,
        _,
    };

    /// USART1 Routing select
    pub const PORTMUX_USART1 = enum(u2) {
        /// TxD: PC0, RxD: PC1, XCK: PC2, XDIR: PC3
        DEFAULT = 0x0,
        /// TxD: PC4, RxD: PC5, XCK: PC6, XDIR: PC7
        ALT1 = 0x1,
        /// TxD: PD6, RxD: PD7, XCK: -, XDIR: -
        ALT2 = 0x2,
        /// Not connected to any pins
        NONE = 0x3,
    };

    /// USART2 Routing select
    pub const PORTMUX_USART2 = enum(u2) {
        /// TxD: PF0, RxD: PF1, XCK: PF2, XDIR: PF3
        DEFAULT = 0x0,
        /// TxD: PF4, RxD: PF5, XCK: - , XDIR: -
        ALT1 = 0x1,
        /// Not connected to any pins
        NONE = 0x3,
        _,
    };

    /// EVSYS route A
    /// offset: 0x00
    EVSYSROUTEA: mmio.Mmio(packed struct(u8) {
        /// Event Output A
        EVOUTA: PORTMUX_EVOUTA,
        /// Event Output B
        EVOUTB: PORTMUX_EVOUTB,
        /// Event Output C
        EVOUTC: PORTMUX_EVOUTC,
        /// Event Output D
        EVOUTD: PORTMUX_EVOUTD,
        /// Event Output E
        EVOUTE: PORTMUX_EVOUTE,
        /// Event Output F
        EVOUTF: PORTMUX_EVOUTF,
        padding: u2 = 0,
    }),
    /// CCL route A
    /// offset: 0x01
    CCLROUTEA: mmio.Mmio(packed struct(u8) {
        /// CCL Look-Up Table 0 Signals
        LUT0: PORTMUX_LUT0,
        /// CCL Look-Up Table 1 Signals
        LUT1: PORTMUX_LUT1,
        /// CCL Look-Up Table 2 Signals
        LUT2: PORTMUX_LUT2,
        padding: u5 = 0,
    }),
    /// USART route A
    /// offset: 0x02
    USARTROUTEA: mmio.Mmio(packed struct(u8) {
        /// USART0 Routing
        USART0: PORTMUX_USART0,
        /// USART1 Routing
        USART1: PORTMUX_USART1,
        padding: u3 = 0,
    }),
    /// USART route B
    /// offset: 0x03
    USARTROUTEB: mmio.Mmio(packed struct(u8) {
        /// USART2 Routing
        USART2: PORTMUX_USART2,
        padding: u6 = 0,
    }),
    /// offset: 0x04
    reserved4: [1]u8,
    /// SPI route A
    /// offset: 0x05
    SPIROUTEA: mmio.Mmio(packed struct(u8) {
        /// SPI0 Signals
        SPI0: PORTMUX_SPI0,
        padding: u5 = 0,
    }),
    /// TWI route A
    /// offset: 0x06
    TWIROUTEA: mmio.Mmio(packed struct(u8) {
        /// TWI0 Signals
        TWI0: PORTMUX_TWI0,
        padding: u6 = 0,
    }),
    /// TCA route A
    /// offset: 0x07
    TCAROUTEA: mmio.Mmio(packed struct(u8) {
        /// TCA0 Signals
        TCA0: PORTMUX_TCA0,
        /// TCA1 Signals
        TCA1: PORTMUX_TCA1,
        padding: u2 = 0,
    }),
    /// TCB route A
    /// offset: 0x08
    TCBROUTEA: mmio.Mmio(packed struct(u8) {
        /// TCB0 Output
        TCB0: PORTMUX_TCB0,
        /// TCB1 Output
        TCB1: PORTMUX_TCB1,
        /// TCB2 Output
        TCB2: PORTMUX_TCB2,
        /// TCB3 Output
        TCB3: PORTMUX_TCB3,
        padding: u4 = 0,
    }),
    /// offset: 0x09
    reserved9: [1]u8,
    /// AC route A
    /// offset: 0x0a
    ACROUTEA: mmio.Mmio(packed struct(u8) {
        /// Analog Comparator 0 Output
        AC0: PORTMUX_AC0,
        /// Analog Comparator 1 Output
        AC1: PORTMUX_AC1,
        padding: u6 = 0,
    }),
};
