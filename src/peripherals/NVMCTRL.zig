const mmio = @import("mmio.zig");

pub const NVMCTRL = extern struct {
    /// Command select
    pub const NVMCTRL_CMD = enum(u7) {
        /// No Command
        NOCMD = 0x0,
        /// No Operation
        NOOP = 0x1,
        /// Flash Page Write
        FLPW = 0x4,
        /// Flash Page Erase and Write
        FLPERW = 0x5,
        /// Flash Page Erase
        FLPER = 0x8,
        /// Flash 2-page erase enable
        FLMPER2 = 0x9,
        /// Flash 4-page erase enable
        FLMPER4 = 0xa,
        /// Flash 8-page erase enable
        FLMPER8 = 0xb,
        /// Flash 16-page erase enable
        FLMPER16 = 0xc,
        /// Flash 32-page erase enable
        FLMPER32 = 0xd,
        /// Flash Page Buffer Clear
        FLPBCLR = 0xf,
        /// EEPROM Page Write
        EEPW = 0x14,
        /// EEPROM Page Erase and Write
        EEPERW = 0x15,
        /// EEPROM Page Erase
        EEPER = 0x17,
        /// EEPROM Page Buffer Clear
        EEPBCLR = 0x1f,
        /// Chip Erase Command (UPDI only)
        CHER = 0x20,
        /// EEPROM Erase Command (UPDI only)
        EECHER = 0x30,
        _,
    };

    /// Write error select
    pub const NVMCTRL_ERROR = enum(u3) {
        /// No Error
        NOERROR = 0x0,
        /// Attempt to program write protected area
        WRITEPROTECT = 0x2,
        /// Selecting new write command while write command already seleted
        CMDCOLLISION = 0x3,
        /// Address cannot be written with selected command
        WRONGSECTION = 0x4,
        _,
    };

    /// Flash Mapping in Data space select
    pub const NVMCTRL_FLMAP = enum(u2) {
        /// Flash section 0, 0 - 32KB
        SECTION0 = 0x0,
        /// Flash section 1, 32 - 64KB
        SECTION1 = 0x1,
        /// Flash section 2, 64 - 96KB
        SECTION2 = 0x2,
        /// Flash section 3, 96 - 128KB
        SECTION3 = 0x3,
    };

    /// Control A
    /// offset: 0x00
    CTRLA: mmio.Mmio(packed struct(u8) {
        /// Command
        CMD: NVMCTRL_CMD,
        padding: u1 = 0,
    }),
    /// Control B
    /// offset: 0x01
    CTRLB: mmio.Mmio(packed struct(u8) {
        /// Application Code Write Protect
        APPCODEWP: u1,
        /// Boot Read Protect
        BOOTRP: u1,
        /// Application Data Write Protect
        APPDATAWP: u1,
        /// EEPROM Write Protect
        EEWP: u1,
        /// Flash Mapping in Data space
        FLMAP: NVMCTRL_FLMAP,
        reserved7: u1 = 0,
        /// Flash Mapping Lock
        FLMAPLOCK: u1,
    }),
    /// offset: 0x02
    reserved2: [2]u8,
    /// Interrupt Control
    /// offset: 0x04
    INTCTRL: mmio.Mmio(packed struct(u8) {
        /// EEPROM Ready
        EEREADY: u1,
        /// Flash Ready
        FLREADY: u1,
        padding: u6 = 0,
    }),
    /// Interrupt Flags
    /// offset: 0x05
    INTFLAGS: mmio.Mmio(packed struct(u8) {
        /// EEPROM Ready
        EEREADY: u1,
        /// Flash Ready
        FLREADY: u1,
        padding: u6 = 0,
    }),
    /// Status
    /// offset: 0x06
    STATUS: mmio.Mmio(packed struct(u8) {
        /// EEPROM busy
        EEBUSY: u1,
        /// Flash busy
        FLBUSY: u1,
        reserved4: u2 = 0,
        /// Write error
        ERROR: NVMCTRL_ERROR,
        padding: u1 = 0,
    }),
    /// offset: 0x07
    reserved7: [1]u8,
    /// Data
    /// offset: 0x08
    DATA: u16,
    /// offset: 0x0a
    reserved10: [2]u8,
    /// Address
    /// offset: 0x0c
    ADDR: mmio.Mmio(packed struct(u32) {
        /// Address
        ADDR: u24,
        padding: u8 = 0,
    }),
};
