const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const file = try std.fs.cwd().openFile("main.wasm", .{});
    defer file.close();
    const contents = try file.readToEndAlloc(allocator, 2000);
    defer allocator.free(contents);
    std.debug.print("{s}", .{std.fmt.fmtSliceHexLower(contents)});
}
