const std = @import("std");

const DecodeError = error{
    InvalidMagicNumber,
    UnsupportedVersionNumber,
};

const SectionID = enum {
    custom,
    type,
    import,
    function,
    table,
    memory,
    global,
    _export,
    start,
    element,
    code,
    data,
    data_count,
};

pub fn decode_preamble(reader: anytype) !void {
    const magic = [_]u8{ 0x00, 0x61, 0x73, 0x6D };
    if (!try reader.isBytes(&magic)) {
        return DecodeError.InvalidMagicNumber;
    }
    const version = [_]u8{ 0x01, 0x00, 0x00, 0x00 };
    if (!try reader.isBytes(&version)) {
        return DecodeError.UnsupportedVersionNumber;
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    const file = try std.fs.cwd().openFile(args[1], .{});
    defer file.close();
    const reader = file.reader();
    try decode_preamble(reader);
}
