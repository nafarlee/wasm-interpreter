const std = @import("std");

const DecodeError = error{
    InvalidMagicNumber,
    UnsupportedVersionNumber,
};

pub fn decode_preamble(bytes: []u8, index: *usize) !void {
    const magic = [_]u8{ 0x00, 0x61, 0x73, 0x6D };
    if (!std.mem.eql(u8, &magic, bytes[index.* .. index.* + 4])) {
        return DecodeError.InvalidMagicNumber;
    }
    const version = [_]u8{ 0x01, 0x00, 0x00, 0x00 };
    if (!std.mem.eql(u8, &version, bytes[index.* + 4 .. index.* + 8])) {
        return DecodeError.UnsupportedVersionNumber;
    }
    index.* += 8;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const file = try std.fs.cwd().openFile("main.wasm", .{});
    defer file.close();
    const bytes = try file.readToEndAlloc(allocator, 2000);
    defer allocator.free(bytes);
    var index: usize = 0;
    try decode_preamble(bytes, &index);
}
