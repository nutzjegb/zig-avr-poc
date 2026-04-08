const mmio = @import("mmio.zig");

pub const DAC = extern struct {
    /// Output Buffer Range select
    pub const DAC_OUTRANGE = enum(u2) {
        /// Output buffer automatically choose best range
        AUTO = 0x0,
        /// Output buffer configured to low range
        LOW = 0x2,
        /// Output buffer configured to high range
        HIGH = 0x3,
        _,
    };

    /// Control Register A
    /// offset: 0x00
    CTRLA: mmio.Mmio(packed struct(u8) {
        /// DAC Enable
        ENABLE: u1,
        reserved4: u3 = 0,
        /// Output Buffer Range
        OUTRANGE: DAC_OUTRANGE,
        /// Output Buffer Enable
        OUTEN: u1,
        /// Run in Standby Mode
        RUNSTDBY: u1,
    }),
    /// offset: 0x01
    reserved1: [1]u8,
    /// DATA Register
    /// offset: 0x02
    DATA: mmio.Mmio(packed struct(u16) {
        reserved6: u6 = 0,
        /// Data
        DATA: u10,
    }),
};
