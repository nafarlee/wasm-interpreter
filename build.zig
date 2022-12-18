const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const exe = b.addExecutable("wasm-interpreter", "src/main.zig");
    exe.setTarget(b.standardTargetOptions(.{}));
    exe.setBuildMode(b.standardReleaseOptions());
    exe.install();
}
