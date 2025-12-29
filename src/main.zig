const raylib = @import("c.zig").raylib;
const BG = @import("bg.zig");
const Matrix = @import("matrix.zig");
const Tile = @import("tile.zig");
const Camera = @import("camera.zig");
const Window = @import("window.zig");
const ColorSelector = @import("color_selector.zig");
const Assets = @import("assets.zig");
pub fn main() !void {
    const window: Window = .{ .width = 1920, .height = 1080 };
    raylib.InitWindow(window.width, window.height, "paint");
    defer raylib.CloseWindow();

    var assets: Assets = .{};
    try assets.load();
    defer assets.unload();

    var matrix: Matrix = undefined;
    initMatrix(&matrix, 16, 16);
    var camera: Camera = .{ .width = 1024, .height = 512, .x = 0, .y = 0, .zoom = 10, .speed = 40 };
    var bg: BG = .{ .color = raylib.GRAY };
    const color_selector: ColorSelector = .{
        .selected = raylib.BLACK,
    };

    while (!raylib.WindowShouldClose()) {
        camera.checkInput();
        matrix.checkInput(&camera, &color_selector.selected);

        raylib.BeginDrawing();
        defer raylib.EndDrawing();

        raylib.ClearBackground(bg.color);
        camera.drawRegion(&assets);
        for (0..matrix.width) |i| {
            for (0..matrix.height) |j| {
                matrix.tiles[i][j].draw(&camera);
            }
        }
    }
    try @import("tga.zig").encode(&matrix);
}

fn initMatrix(matrix: *Matrix, width: u16, height: u16) void {
    matrix.width = width;
    matrix.height = height;
    for (0..width) |i| {
        for (0..height) |j| {
            matrix.tiles[i][j] = .{ .color = raylib.SKYBLUE, .x = @intCast(i), .y = @intCast(j) };
        }
    }
}
