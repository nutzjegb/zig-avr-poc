const mmio = @import("mmio.zig");

pub const PORT = extern struct {
    /// Event Generator 0 Select
    pub const PORT_EVGEN0SEL = enum(u3) {
        /// Pin 0 used as event generator
        PIN0 = 0x0,
        /// Pin 1 used as event generator
        PIN1 = 0x1,
        /// Pin 2 used as event generator
        PIN2 = 0x2,
        /// Pin 3 used as event generator
        PIN3 = 0x3,
        /// Pin 4 used as event generator
        PIN4 = 0x4,
        /// Pin 5 used as event generator
        PIN5 = 0x5,
        /// Pin 6 used as event generator
        PIN6 = 0x6,
        /// Pin 7 used as event generator
        PIN7 = 0x7,
    };

    /// Event Generator 1 Select
    pub const PORT_EVGEN1SEL = enum(u3) {
        /// Pin 0 used as event generator
        PIN0 = 0x0,
        /// Pin 1 used as event generator
        PIN1 = 0x1,
        /// Pin 2 used as event generator
        PIN2 = 0x2,
        /// Pin 3 used as event generator
        PIN3 = 0x3,
        /// Pin 4 used as event generator
        PIN4 = 0x4,
        /// Pin 5 used as event generator
        PIN5 = 0x5,
        /// Pin 6 used as event generator
        PIN6 = 0x6,
        /// Pin 7 used as event generator
        PIN7 = 0x7,
    };

    /// Input Level Select
    pub const PORT_INLVL = enum(u1) {
        /// Schmitt-Trigger input level
        ST = 0x0,
        /// TTL Input level
        TTL = 0x1,
    };

    /// Input/Sense Configuration select
    pub const PORT_ISC = enum(u3) {
        /// Interrupt disabled but input buffer enabled
        INTDISABLE = 0x0,
        /// Sense Both Edges
        BOTHEDGES = 0x1,
        /// Sense Rising Edge
        RISING = 0x2,
        /// Sense Falling Edge
        FALLING = 0x3,
        /// Digital Input Buffer disabled
        INPUT_DISABLE = 0x4,
        /// Sense low Level
        LEVEL = 0x5,
        _,
    };

    /// Data Direction
    /// offset: 0x00
    DIR: u8,
    /// Data Direction Set
    /// offset: 0x01
    DIRSET: u8,
    /// Data Direction Clear
    /// offset: 0x02
    DIRCLR: u8,
    /// Data Direction Toggle
    /// offset: 0x03
    DIRTGL: u8,
    /// Output Value
    /// offset: 0x04
    OUT: u8,
    /// Output Value Set
    /// offset: 0x05
    OUTSET: u8,
    /// Output Value Clear
    /// offset: 0x06
    OUTCLR: u8,
    /// Output Value Toggle
    /// offset: 0x07
    OUTTGL: u8,
    /// Input Value
    /// offset: 0x08
    IN: u8,
    /// Interrupt Flags
    /// offset: 0x09
    INTFLAGS: mmio.Mmio(packed struct(u8) {
        /// Pin Interrupt Flag
        INT: u8,
    }),
    /// Port Control
    /// offset: 0x0a
    PORTCTRL: mmio.Mmio(packed struct(u8) {
        /// Slew Rate Limit Enable
        SRL: u1,
        padding: u7 = 0,
    }),
    /// Pin Control Config
    /// offset: 0x0b
    PINCONFIG: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin Control Update
    /// offset: 0x0c
    PINCTRLUPD: u8,
    /// Pin Control Set
    /// offset: 0x0d
    PINCTRLSET: u8,
    /// Pin Control Clear
    /// offset: 0x0e
    PINCTRLCLR: u8,
    /// offset: 0x0f
    reserved15: [1]u8,
    /// Pin 0 Control
    /// offset: 0x10
    PIN0CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 1 Control
    /// offset: 0x11
    PIN1CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 2 Control
    /// offset: 0x12
    PIN2CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 3 Control
    /// offset: 0x13
    PIN3CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 4 Control
    /// offset: 0x14
    PIN4CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 5 Control
    /// offset: 0x15
    PIN5CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 6 Control
    /// offset: 0x16
    PIN6CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Pin 7 Control
    /// offset: 0x17
    PIN7CTRL: mmio.Mmio(packed struct(u8) {
        /// Input/Sense Configuration
        ISC: PORT_ISC,
        /// Pullup enable
        PULLUPEN: u1,
        reserved6: u2 = 0,
        /// Input Level Select
        INLVL: PORT_INLVL,
        /// Inverted I/O Enable
        INVEN: u1,
    }),
    /// Event Generation Control A
    /// offset: 0x18
    EVGENCTRLA: mmio.Mmio(packed struct(u8) {
        /// Event Generator 0 Select
        EVGEN0SEL: PORT_EVGEN0SEL,
        reserved4: u1 = 0,
        /// Event Generator 1 Select
        EVGEN1SEL: PORT_EVGEN1SEL,
        padding: u1 = 0,
    }),
};
