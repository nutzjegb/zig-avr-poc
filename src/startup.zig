const std = @import("std");
const main = @import("main.zig");
const AVR64EA48 = @import("AVR64EA48.zig");

pub fn panic(msg: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    @branchHint(.cold);

    // Assume UART is configured
    main.putstr("PANIC: ");
    main.putstr(msg);
    while (true) {}
}

comptime {
    // Comptime block to force generating the vector table
    // stolen from https://github.com/FireFox317/avr-arduino-zig

    std.debug.assert(std.mem.eql(u8, "RESET", std.meta.fields(AVR64EA48.VectorTable)[0].name));
    var asm_str: []const u8 = ".section .vectors\njmp _start\n";

    for (std.meta.fields(AVR64EA48.VectorTable)[1..]) |_| {
        const new_insn = "jmp _unhandled_vector";
        asm_str = asm_str ++ new_insn ++ "\n";
    }
    asm (asm_str);
}

export fn _unhandled_vector() linksection(".vectors") callconv(.c) noreturn {
    // We put this function in .vectors as the linker sometimes optimizes it away
    // zig does not appear to be the problem as adding something like
    // _ = &_unhandled_vector;
    // in a comptime block does not solve it..
    // See the code above, jmp _unhandled_vector is silently replaced with jmp 0
    // Which should cause link errors (but does not), therefore I suspect the linker is to blame
    @panic("Unhandled IRQ\n");
}

export fn _start() callconv(.c) noreturn {
    // At startup the stack pointer is at the end of RAM
    // so, no need to set it manually!

    copy_data_to_ram();
    clear_bss();

    main.main();
}

fn copy_data_to_ram() void {
    asm volatile (
        \\  ; load Z register with the address of the data in flash
        \\  ldi r30, lo8(_data_load_start)
        \\  ldi r31, hi8(_data_load_start)
        \\  ; load X register with address of the data in ram
        \\  ldi r26, lo8(_data_start)
        \\  ldi r27, hi8(_data_start)
        \\  ; load address of end of the data in ram
        \\  ldi r24, lo8(_data_end)
        \\  ldi r25, hi8(_data_end)
        \\  rjmp .L2
        \\
        \\.L1:
        \\  lpm r18, Z+ ; copy from Z into r18 and increment Z
        \\  st X+, r18  ; store r18 at location X and increment X
        \\
        \\.L2:
        \\  cp r26, r24
        \\  cpc r27, r25 ; check and branch if we are at the end of data
        \\  brne .L1
    );
    // Probably a good idea to add clobbers here, but compiler doesn't seem to care
}

fn clear_bss() void {
    asm volatile (
        \\  ; load X register with the beginning of bss section
        \\  ldi r26, lo8(_bss_start)
        \\  ldi r27, hi8(_bss_start)
        \\  ; load end of the bss in registers
        \\  ldi r24, lo8(_bss_end)
        \\  ldi r25, hi8(_bss_end)
        \\  ldi r18, 0x00
        \\  rjmp .L4
        \\
        \\.L3:
        \\  st X+, r18
        \\
        \\.L4:
        \\  cp r26, r24
        \\  cpc r27, r25 ; check and branch if we are at the end of bss
        \\  brne .L3
    );
    // Probably a good idea to add clobbers here, but compiler doesn't seem to care
}
