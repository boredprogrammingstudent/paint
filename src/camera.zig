const raylib = @import("c.zig").raylib;
const Assets = @import("assets.zig");
width: u16,
height: u16,
x: f32,
y: f32,
zoom: u16,
speed: f32,
pub const MAX_ZOOM = 45;
pub fn checkInput(self: *@This()) void {
    if (raylib.IsKeyDown(raylib.KEY_W)) self.y -= self.speed * raylib.GetFrameTime();
    if (raylib.IsKeyDown(raylib.KEY_S)) self.y += self.speed * raylib.GetFrameTime();
    if (raylib.IsKeyDown(raylib.KEY_A)) self.x -= self.speed * raylib.GetFrameTime();
    if (raylib.IsKeyDown(raylib.KEY_D)) self.x += self.speed * raylib.GetFrameTime();
    if (raylib.IsKeyPressed(raylib.KEY_R)) {
        self.x = 0;
        self.y = 0;
        self.zoom = 1;
    }
    if (raylib.IsKeyPressed(raylib.KEY_UP)) {
        if (self.zoom < MAX_ZOOM - 1) self.zoom += 1;
    }
    if (raylib.IsKeyPressed(raylib.KEY_DOWN)) {
        if (self.zoom > 1) self.zoom -= 1;
    }
}
pub fn drawRegion(self: *@This(), assets: *Assets) void {
    raylib.DrawTextureRec(assets.grid, .{ .width = @floatFromInt(self.width), .height = @floatFromInt(self.height), .x = 0, .y = 0 }, .{ .x = self.x, .y = self.y }, raylib.WHITE);
}
