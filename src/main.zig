const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().openFile("main.wasm", .{});
    defer file.close();
    const reader = file.reader();
    while (true) {
        const byte = reader.readByte() catch return;
        std.debug.print("{x:0^2} ", .{byte});
    }
}
