const Scene = @import("scene.zig");
const Window = @import("window.zig");
const Assets = @import("assets.zig");
const raylib = @import("c.zig").raylib;
const BG = @import("bg.zig");
const Button = @import("button.zig");

pub var bg: BG = .{ .color = raylib.LIGHTGRAY };
pub var createBtn: Button = undefined;
var currScene: *u8 = undefined;
scene: Scene,

pub fn init(curr: *u8, window: *const Window) @This() {
    currScene = curr;
    createBtn = .{ .x = window.width - 500, .y = 10, .color = raylib.RED, .width = 250, .height = 100, .text = "create", .callback = switchToDrawingInterface };
    return .{ .scene = .{ .vtable = &.{ .draw = @This().draw, .update = @This().update } } };
}

fn update(window: *const Window, assets: *Assets) void {
    _ = window;
    _ = assets;
    createBtn.update();
}
fn draw(window: *const Window, assets: *Assets) void {
    _ = window;
    _ = assets;
    raylib.ClearBackground(bg.color);
    createBtn.draw();
}

fn switchToDrawingInterface() void {
    currScene.* = 1;
}
