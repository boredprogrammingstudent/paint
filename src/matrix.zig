const Tile = @import("tile.zig");
const raylib = @import("c.zig").raylib;
const Window = @import("window.zig");
tiles: [128][128]Tile,
width: u16,
height: u16,
pub fn checkInput(self: *@This(), window: *const Window, color: *const raylib.Color) void {
    if (raylib.IsMouseButtonDown(raylib.MOUSE_BUTTON_LEFT)) {
        const tileSize = @as(f32, @floatFromInt(window.height)) / @as(f32, @floatFromInt(self.height));
        const mousePos = raylib.GetMousePosition();
        const x = @as(isize, @intFromFloat(mousePos.x / tileSize));
        const y = @as(isize, @intFromFloat(mousePos.y / tileSize));
        if (x < 0 or x >= self.width) return;
        if (y < 0 or y >= self.height) return;
        self.tiles[@intCast(x)][@intCast(y)].color = color.*;
    }
}

pub fn init(width: u16, height: u16) @This() {
    var matrix: @This() = undefined;
    matrix.width = width;
    matrix.height = height;
    for (0..width) |i| {
        for (0..height) |j| {
            matrix.tiles[i][j] = .{ .color = raylib.SKYBLUE, .x = @intCast(i), .y = @intCast(j) };
        }
    }
    return matrix;
}

pub fn draw(self: *@This(), window: *const Window) void {
    const tileSize = window.height / self.height;
    for (0..self.width) |i| {
        for (0..self.height) |j| {
            raylib.DrawRectangle(@intCast(i * tileSize), @intCast(j * tileSize), tileSize, tileSize, self.tiles[i][j].color);
        }
    }
}
