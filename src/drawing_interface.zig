const Matrix = @import("matrix.zig");
const raylib = @import("c.zig").raylib;
const Camera = @import("camera.zig");
const BG = @import("bg.zig");
const ColorPalette = @import("color_palette.zig");
const Scene = @import("scene.zig");
const Assets = @import("assets.zig");
const Window = @import("window.zig");

pub var matrix: Matrix = Matrix.init(16, 16);
pub var camera: Camera = .{ .width = 1024, .height = 512, .x = 0, .y = 0, .zoom = 10, .speed = 40 };
pub var bg: BG = .{ .color = raylib.LIGHTGRAY };
pub var palette: ColorPalette = ColorPalette.default();
pub var selected_color = raylib.BLACK;

scene: Scene,

pub fn init() @This() {
    return .{ .scene = .{ .vtable = &.{ .draw = @This().draw, .update = @This().update } } };
}

pub fn update(window: *const Window, assets: *Assets) void {
    camera.checkInput();
    matrix.checkInput(&camera, &selected_color);
    palette.checkInput(window, &selected_color);
    _ = assets;
}

pub fn draw(window: *const Window, assets: *Assets) void {
    raylib.ClearBackground(bg.color);
    camera.drawRegion(assets);
    for (0..matrix.width) |i| {
        for (0..matrix.height) |j| {
            matrix.tiles[i][j].draw(&camera);
        }
    }
    palette.draw(window);
}

pub fn getMatrix(self: *const @This()) *Matrix {
    _ = self;
    return &matrix;
}
