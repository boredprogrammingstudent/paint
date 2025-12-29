const raylib = @import("c.zig").raylib;
const Camera = @import("camera.zig");
color: raylib.Color,
x: i32,
y: i32,
pub fn draw(self: *@This(), camera: *Camera) void {
    const posX: f32 = (@as(f32, @floatFromInt((self.x))) - camera.x) * @as(f32, @floatFromInt(camera.zoom));
    const posY: f32 = (@as(f32, @floatFromInt(self.y)) - camera.y) * @as(f32, @floatFromInt(camera.zoom));
    if (posX < 0) return;
    if (posY < 0) return;
    if (posX < camera.x) return;
    if (posY < camera.y) return;
    if (posX + @as(f32, @floatFromInt(camera.zoom)) > camera.x + @as(f32, @floatFromInt(camera.width))) return;
    if (posY + @as(f32, @floatFromInt(camera.zoom)) > camera.y + @as(f32, @floatFromInt(camera.height))) return;
    raylib.DrawRectangle(@intFromFloat(posX), @intFromFloat(posY), camera.zoom, camera.zoom, self.color);
}
