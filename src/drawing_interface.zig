const Matrix = @import("matrix.zig");
const raylib = @import("c.zig").raylib;
const BG = @import("bg.zig");
const ColorPalette = @import("color_palette.zig");
const Scene = @import("scene.zig");
const Assets = @import("assets.zig");
const Window = @import("window.zig");

pub var matrix: Matrix = Matrix.init(32, 32);
pub var bg: BG = .{ .color = raylib.LIGHTGRAY };
pub var palette: ColorPalette = ColorPalette.default();
pub var selected_color = raylib.BLACK;

scene: Scene,

pub fn init() @This() {
    return .{ .scene = .{ .vtable = &.{ .draw = @This().draw, .update = @This().update } } };
}

pub fn update(window: *const Window, assets: *Assets) void {
    matrix.checkInput(window, &selected_color);
    palette.checkInput(window, &selected_color);
    _ = assets;
}

pub fn draw(window: *const Window, assets: *Assets) void {
    raylib.ClearBackground(bg.color);

    matrix.draw(window);
    palette.draw(window);
    _ = assets;
}

pub fn getMatrix(self: *const @This()) *Matrix {
    _ = self;
    return &matrix;
}
