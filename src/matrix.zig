const Tile = @import("tile.zig");
const Camera = @import("camera.zig");
const raylib = @import("c.zig").raylib;
tiles: [128][128]Tile,
width: u16,
height: u16,
pub fn checkInput(self: *@This(), camera: *Camera, color: *const raylib.Color) void {
    if (raylib.IsMouseButtonDown(raylib.MOUSE_BUTTON_LEFT)) {
        const x: isize = @as(isize, @intFromFloat(raylib.GetMousePosition().x / @as(f32, @floatFromInt(camera.zoom)) + camera.x));
        const y: isize = @as(isize, @intFromFloat(raylib.GetMousePosition().y / @as(f32, @floatFromInt(camera.zoom)) + camera.y));
        if (x < 0) return;
        if (x > self.width) return;
        if (y < 0) return;
        if (y > self.height) return;
        self.tiles[@intCast(x)][@intCast(y)].color = color.*;
    }
}
