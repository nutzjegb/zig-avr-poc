const mmio = @import("mmio.zig");

pub const SLPCTRL = extern struct {
    /// Sleep mode select
    pub const SLPCTRL_SMODE = enum(u2) {
        /// Idle mode
        IDLE = 0x0,
        /// Standby Mode
        STDBY = 0x1,
        /// Power-down Mode
        PDOWN = 0x2,
        _,
    };

    /// Control A
    /// offset: 0x00
    CTRLA: mmio.Mmio(packed struct(u8) {
        /// Sleep enable
        SEN: u1,
        /// Sleep mode
        SMODE: SLPCTRL_SMODE,
        padding: u5 = 0,
    }),
};
