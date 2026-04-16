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

fn gen_vector_table(interrupts: AVR64EA48.VectorTable) []const u8 {
    // Start of the VectorTable, jump to _start
    var asm_str: []const u8 = ".section .vectors\njmp _start\n";

    for (std.meta.fields(@TypeOf(interrupts))) |field| {
        const unhandled_ins = "jmp _unhandled_vector\n";

        const entry = @field(interrupts, field.name);
        const ins = switch (entry) {
            .unhandled => unhandled_ins,
            .handler => |handler| blk: {
                const wrapper_name = "_wrap_" ++ field.name;
                const exported_fn = struct {
                    fn wrapper() callconv(.avr_interrupt) void {
                        // Function is usually inlined, so this is only
                        // really needed to hint the compiler this is a special
                        // IRQ entry
                        handler();
                    }
                }.wrapper;

                // Export our wrapper function
                // (put it in .vectors to be sure the linker does not optimize it away)
                @export(&exported_fn, .{
                    .name = wrapper_name,
                    .section = ".vectors",
                });

                // And add the entry to the vector table
                break :blk "jmp " ++ wrapper_name ++ "\n";
            },
        };
        asm_str = asm_str ++ ins;
    }
    return asm_str;
}

comptime {
    // Comptime block to force generating the vector table
    // bit inspired by microzig and https://github.com/FireFox317/avr-arduino-zig
    asm (gen_vector_table(main.interrupts));
}

export fn _unhandled_vector() linksection(".vectors") callconv(.avr_interrupt) noreturn {
    // We put this function in .vectors as the linker sometimes optimizes it away
    // zig does not appear to be the problem here as adding something like
    // _ = &_unhandled_vector;
    // in a comptime block does not solve it..
    // The actual emitted code (also see the code above) is jmp 0, instead of jmp _unhandled_vector
    // Which should cause link errors? Probably the linker tries to be smart
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

    // The above could be replaced with something like this I suppose
    // @setRuntimeSafety(false);
    // const bss_start = @extern(*u8, .{ .name = "_bss_start" });
    // const bss_end = @extern(*u8, .{ .name = "_bss_end" });
    // for (@intFromPtr(bss_start)..@intFromPtr(bss_end)) |addr| {
    //     const ptr: *u8 = @ptrFromInt(addr);
    //     ptr.* = 0;
    // }
    // Or something like this?
    // (zig 0.15.2 appears to crash)
    // const bss = @as([*]u8, @ptrCast(bss_start))[0 .. @intFromPtr(bss_end) - @intFromPtr(bss_start)];
    // @memset(bss, 0);
}
