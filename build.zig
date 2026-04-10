const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .avr,
        .os_tag = .freestanding,
        .abi = .none,
        .cpu_model = .{
            // Correct model not available, but this has the same CPU features
            .explicit = &std.Target.avr.cpu.avrxmega2,
        },
    });

    const exe = b.addExecutable(.{
        .name = "avr_poc",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/startup.zig"),
            .target = target,
            .optimize = .ReleaseSafe,
        }),
    });
    exe.bundle_compiler_rt = false;
    exe.bundle_ubsan_rt = false;
    exe.setLinkerScript(b.path("src/linker.ld"));
    const exe_path = exe.getEmittedBin();
    b.installArtifact(exe);

    // Add .hex file to output
    const hex = b.addObjCopy(exe_path, .{
        .format = .hex,
    });
    hex.step.dependOn(&exe.step);
    const copy_hex = b.addInstallBinFile(hex.getOutput(), "avr_poc.hex");
    b.default_step.dependOn(&copy_hex.step);

    // Add .dis file to output
    // Note zig can also output the generated asm, could be helpfull!
    // (as it is bit more readable then the objdump output)
    const avr_objdump = b.addSystemCommand(&.{
        "avr-objdump",
        "-xd",
    });
    avr_objdump.addFileArg(exe_path);
    avr_objdump.step.dependOn(&exe.step);
    const dis = avr_objdump.captureStdOut();
    const copy_dis = b.addInstallBinFile(dis, "avr_poc.dis");
    b.default_step.dependOn(&copy_dis.step);
}
