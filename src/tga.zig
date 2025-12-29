const Tile = @import("tile.zig");
const std = @import("std");
const File = std.fs.File;
const Writer = std.Io.Writer;
const Matrix = @import("matrix.zig");
pub fn encode(matrix: *Matrix) !void {
    var file = try std.fs.cwd().createFile("new_image.tga", .{ .read = true });
    defer file.close();
    var buffer: [24000]u8 = undefined;
    var file_writer = file.writer(&buffer);
    var writer = &file_writer.interface;
    try encodeHeader(writer, matrix.width, matrix.height);
    try encodeBody(writer, matrix);
    try writer.flush();
}

fn encodeHeader(writer: *Writer, width: u16, height: u16) !void {
    const header: [18]u8 = .{
        0, // ID length
        0, // Color map type
        2, // Image type: uncompressed true-color
        0, 0, 0, 0, 0, // Color map origin & length & depth
        0, 0, // X-origin (little-endian)
        0, 0, // Y-origin (little-endian)
        @intCast(width & 0xFF), @intCast((width >> 8) & 0xFF), // Width, little-endian
        @intCast(height & 0xFF), @intCast((height >> 8) & 0xFF), // Height, little-endian
        32, // Pixel depth
        8, // Image descriptor (8-bit alpha, bottom-left origin)
    };

    try writer.writeAll(&header);
}

fn encodeBody(writer: *Writer, matrix: *Matrix) !void {
    for (0..matrix.height) |j| {
        for (0..matrix.width) |i| {
            const h = matrix.height - j;
            const pixel: [4]u8 = .{ matrix.tiles[i][h - 1].color.b, matrix.tiles[i][h - 1].color.g, matrix.tiles[i][h - 1].color.r, matrix.tiles[i][h - 1].color.a };
            try writer.writeAll(&pixel);
        }
    }
}
