const raylib = @import("c.zig").raylib;
color: raylib.Color,
pub fn draw(self: *@This(), x: c_int, y: c_int, width: c_int, height: c_int) void {
    raylib.DrawRectangle(x, y, width + 2, height + 2, raylib.BLACK);
    raylib.DrawRectangle(x, y, width, height, self.color);
}
