const mmio = @import("mmio.zig");

pub const EVSYS = extern struct {
    /// Channel generator select
    pub const EVSYS_CHANNEL = enum(u8) {
        /// Off
        OFF = 0x0,
        /// UPDI SYNCH character
        UPDI_SYNCH = 0x1,
        /// Real Time Counter overflow
        RTC_OVF = 0x6,
        /// Real Time Counter compare
        RTC_CMP = 0x7,
        /// Periodic Interrupt Timer Event 0
        RTC_PITEV0 = 0x8,
        /// Periodic Interrupt Timer Event 1
        RTC_PITEV1 = 0x9,
        /// Configurable Custom Logic LUT0
        CCL_LUT0 = 0x10,
        /// Configurable Custom Logic LUT1
        CCL_LUT1 = 0x11,
        /// Configurable Custom Logic LUT2
        CCL_LUT2 = 0x12,
        /// Configurable Custom Logic LUT3
        CCL_LUT3 = 0x13,
        /// Analog Comparator 0 out
        AC0_OUT = 0x20,
        /// Analog Comparator 1 out
        AC1_OUT = 0x21,
        /// ADC 0 Result Ready
        ADC0_RES = 0x24,
        /// ADC 0 Sample Ready
        ADC0_SAMP = 0x25,
        /// ADC 0 Window Compare
        ADC0_WCMP = 0x26,
        /// Port A Event 0
        PORTA_EV0 = 0x40,
        /// Port A Event 1
        PORTA_EV1 = 0x41,
        /// Port B Event 0
        PORTB_EV0 = 0x42,
        /// Port B Event 1
        PORTB_EV1 = 0x43,
        /// Port C Event 0
        PORTC_EV0 = 0x44,
        /// Port C Event 1
        PORTC_EV1 = 0x45,
        /// Port D Event 0
        PORTD_EV0 = 0x46,
        /// Port D Event 1
        PORTD_EV1 = 0x47,
        /// Port E Event 0
        PORTE_EV0 = 0x48,
        /// Port E Event 1
        PORTE_EV1 = 0x49,
        /// Port F Event 0
        PORTF_EV0 = 0x4a,
        /// Port F Event 1
        PORTF_EV1 = 0x4b,
        /// USART 0 XCK
        USART0_XCK = 0x60,
        /// USART 1 XCK
        USART1_XCK = 0x61,
        /// USART 2 XCK
        USART2_XCK = 0x62,
        /// SPI 0 SCK
        SPI0_SCK = 0x68,
        /// Timer/Counter A0 overflow / low byte timer underflow
        TCA0_OVF_LUNF = 0x80,
        /// Timer/Counter A0 high byte timer underflow
        TCA0_HUNF = 0x81,
        /// Timer/Counter A0 compare 0 / low byte timer compare 0
        TCA0_CMP0_LCMP0 = 0x84,
        /// Timer/Counter A0 compare 1 / low byte timer compare 1
        TCA0_CMP1_LCMP1 = 0x85,
        /// Timer/Counter A0 compare 2 / low byte timer compare 2
        TCA0_CMP2_LCMP2 = 0x86,
        /// Timer/Counter A1 overflow / low byte timer underflow
        TCA1_OVF_LUNF = 0x88,
        /// Timer/Counter A1 high byte timer underflow
        TCA1_HUNF = 0x89,
        /// Timer/Counter A1 compare 0 / low byte timer compare 0
        TCA1_CMP0_LCMP0 = 0x8c,
        /// Timer/Counter A1 compare 1 / low byte timer compare 1
        TCA1_CMP1_LCMP1 = 0x8d,
        /// Timer/Counter A1 compare 2 / low byte timer compare 2
        TCA1_CMP2_LCMP2 = 0x8e,
        /// Timer/Counter B0 capture
        TCB0_CAPT = 0xa0,
        /// Timer/Counter B0 overflow
        TCB0_OVF = 0xa1,
        /// Timer/Counter B1 capture
        TCB1_CAPT = 0xa2,
        /// Timer/Counter B1 overflow
        TCB1_OVF = 0xa3,
        /// Timer/Counter B2 capture
        TCB2_CAPT = 0xa4,
        /// Timer/Counter B2 overflow
        TCB2_OVF = 0xa5,
        /// Timer/Counter B3 capture
        TCB3_CAPT = 0xa6,
        /// Timer/Counter B3 overflow
        TCB3_OVF = 0xa7,
        _,
    };

    /// Software event on channel select
    pub const EVSYS_SWEVENTA = enum(u8) {
        /// Software event on channel 0
        CH0 = 0x1,
        /// Software event on channel 1
        CH1 = 0x2,
        /// Software event on channel 2
        CH2 = 0x4,
        /// Software event on channel 3
        CH3 = 0x8,
        /// Software event on channel 4
        CH4 = 0x10,
        /// Software event on channel 5
        CH5 = 0x20,
        /// Software event on channel 6
        CH6 = 0x40,
        /// Software event on channel 7
        CH7 = 0x80,
        _,
    };

    /// User channel select
    pub const EVSYS_USER = enum(u8) {
        /// Off, No Eventsys Channel connected
        OFF = 0x0,
        /// Connect user to event channel 0
        CHANNEL0 = 0x1,
        /// Connect user to event channel 1
        CHANNEL1 = 0x2,
        /// Connect user to event channel 2
        CHANNEL2 = 0x3,
        /// Connect user to event channel 3
        CHANNEL3 = 0x4,
        /// Connect user to event channel 4
        CHANNEL4 = 0x5,
        /// Connect user to event channel 5
        CHANNEL5 = 0x6,
        _,
    };

    /// Software Event A
    /// offset: 0x00
    SWEVENTA: mmio.Mmio(packed struct(u8) {
        /// Software event on channel select
        SWEVENTA: EVSYS_SWEVENTA,
    }),
    /// offset: 0x01
    reserved1: [15]u8,
    /// Multiplexer Channel 0
    /// offset: 0x10
    CHANNEL0: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// Multiplexer Channel 1
    /// offset: 0x11
    CHANNEL1: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// Multiplexer Channel 2
    /// offset: 0x12
    CHANNEL2: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// Multiplexer Channel 3
    /// offset: 0x13
    CHANNEL3: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// Multiplexer Channel 4
    /// offset: 0x14
    CHANNEL4: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// Multiplexer Channel 5
    /// offset: 0x15
    CHANNEL5: mmio.Mmio(packed struct(u8) {
        /// Channel generator select
        CHANNEL: EVSYS_CHANNEL,
    }),
    /// offset: 0x16
    reserved22: [10]u8,
    /// CCL0 Event A
    /// offset: 0x20
    USERCCLLUT0A: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL0 Event B
    /// offset: 0x21
    USERCCLLUT0B: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL1 Event A
    /// offset: 0x22
    USERCCLLUT1A: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL1 Event B
    /// offset: 0x23
    USERCCLLUT1B: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL2 Event A
    /// offset: 0x24
    USERCCLLUT2A: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL2 Event B
    /// offset: 0x25
    USERCCLLUT2B: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL3 Event A
    /// offset: 0x26
    USERCCLLUT3A: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// CCL3 Event B
    /// offset: 0x27
    USERCCLLUT3B: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// ADC0
    /// offset: 0x28
    USERADC0START: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTA
    /// offset: 0x29
    USEREVSYSEVOUTA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTB
    /// offset: 0x2a
    USEREVSYSEVOUTB: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTC
    /// offset: 0x2b
    USEREVSYSEVOUTC: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTD
    /// offset: 0x2c
    USEREVSYSEVOUTD: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTE
    /// offset: 0x2d
    USEREVSYSEVOUTE: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// EVOUTF
    /// offset: 0x2e
    USEREVSYSEVOUTF: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// USART0
    /// offset: 0x2f
    USERUSART0IRDA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// USART1
    /// offset: 0x30
    USERUSART1IRDA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// USART2
    /// offset: 0x31
    USERUSART2IRDA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCA0 Event A
    /// offset: 0x32
    USERTCA0CNTA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCA0 Event B
    /// offset: 0x33
    USERTCA0CNTB: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCA1 Event A
    /// offset: 0x34
    USERTCA1CNTA: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCA1 Event B
    /// offset: 0x35
    USERTCA1CNTB: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB0 Event A
    /// offset: 0x36
    USERTCB0CAPT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB0 Event B
    /// offset: 0x37
    USERTCB0COUNT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB1 Event A
    /// offset: 0x38
    USERTCB1CAPT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB1 Event B
    /// offset: 0x39
    USERTCB1COUNT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB2 Event A
    /// offset: 0x3a
    USERTCB2CAPT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB2 Event B
    /// offset: 0x3b
    USERTCB2COUNT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB3 Event A
    /// offset: 0x3c
    USERTCB3CAPT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
    /// TCB3 Event B
    /// offset: 0x3d
    USERTCB3COUNT: mmio.Mmio(packed struct(u8) {
        /// User channel select
        USER: EVSYS_USER,
    }),
};
