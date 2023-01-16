const std = @import("std");

pub fn decode_preamble(bytes: []u8, index: *usize) !void {
    const magic = bytes[index.* .. index.* + 4];
    for (magic) |byte| {
        std.debug.print("0x{X:0^2} ", .{byte});
    }
    std.debug.print("\n", .{});
    const version = bytes[index.* + 4 .. index.* + 8];
    for (version) |byte| {
        std.debug.print("0x{X:0^2} ", .{byte});
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const file = try std.fs.cwd().openFile("main.wasm", .{});
    defer file.close();
    const contents = try file.readToEndAlloc(allocator, 2000);
    defer allocator.free(contents);
    std.debug.print("{s}", .{std.fmt.fmtSliceHexLower(contents)});
}
