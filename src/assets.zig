const raylib = @import("c.zig").raylib;
grid: raylib.Texture = undefined,
grid_img: raylib.Image = undefined,
pub fn load(self: *@This()) !void {
    self.grid_img = raylib.LoadImage("src/assets/grid.jpeg");
    self.grid = raylib.LoadTextureFromImage(self.grid_img);
}
pub fn unload(self: *@This()) void {
    raylib.UnloadImage(self.grid_img);
    raylib.UnloadTexture(self.grid);
}
