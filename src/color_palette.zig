const ColorPicker = @import("color_picker.zig");
const raylib = @import("c.zig").raylib;
const Window = @import("window.zig");

const WIDTH = 35;
const HEIGHT = 35;
const BUFFER = 500;
const DELTA = 40;

const N = 10;

pickers: [N]ColorPicker,
isOn: bool,

pub fn draw(self: *@This(), window: *const Window) void {
    if (self.isOn) {
        for (0..self.pickers.len) |i| {
            self.pickers[i].draw(@intCast(window.width - BUFFER + (i * DELTA)), window.height - DELTA, WIDTH, HEIGHT);
        }
    }
}

pub fn checkInput(self: *@This(), window: *const Window, selected_color: *raylib.Color) void {
    if (raylib.IsMouseButtonPressed(raylib.MOUSE_BUTTON_LEFT)) {
        const mousePos = raylib.GetMousePosition();
        if (mousePos.x >= @as(f32, @floatFromInt(window.width - BUFFER)) and
            mousePos.x < @as(f32, @floatFromInt(window.width - BUFFER + (N * DELTA))) and
            mousePos.y < @as(f32, @floatFromInt(window.height)) and
            mousePos.y >= @as(f32, @floatFromInt(window.height - DELTA)))
        {
            selected_color.* = self.pickers[@intCast((@as(u16, @intFromFloat(mousePos.x)) -% window.width +% BUFFER) / DELTA)].color;
        }
    }
}

pub fn default() @This() {
    return .{ .isOn = true, .pickers = .{
        .{ .color = raylib.BLACK },
        .{ .color = raylib.WHITE },
        .{ .color = raylib.GRAY },
        .{ .color = raylib.RED },
        .{ .color = raylib.YELLOW },
        .{ .color = raylib.GREEN },
        .{ .color = raylib.BLUE },
        .{ .color = raylib.PURPLE },
        .{ .color = raylib.ORANGE },
        .{ .color = raylib.PINK },
    } };
}
