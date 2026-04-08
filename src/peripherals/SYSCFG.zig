const mmio = @import("mmio.zig");

pub const SYSCFG = extern struct {
    /// offset: 0x00
    reserved0: [1]u8,
    /// Revision ID
    /// offset: 0x01
    REVID: mmio.Mmio(packed struct(u8) {
        /// Minor Revision
        MINOR: u4,
        /// Major Revision
        MAJOR: u4,
    }),
    /// offset: 0x02
    reserved2: [2]u8,
    /// OCD Message Control
    /// offset: 0x04
    OCDMCTRL: mmio.Mmio(packed struct(u8) {
        /// OCD Message
        OCDM: u8,
    }),
    /// OCD Message Status
    /// offset: 0x05
    OCDMSTATUS: mmio.Mmio(packed struct(u8) {
        /// OCD Message Valid
        VALID: u1,
        padding: u7 = 0,
    }),
};
