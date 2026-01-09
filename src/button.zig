const raylib = @import("c.zig").raylib;

x: u16,
y: u16,
width: u16,
height: u16,
text: [:0]const u8,
color: raylib.Color,
callback: *const fn () void,

pub fn update(self: *@This()) void {
    if (raylib.IsMouseButtonPressed(raylib.MOUSE_BUTTON_LEFT)) {
        const mousePos = raylib.GetMousePosition();
        if (mousePos.x < @as(f32, @floatFromInt(self.x))) return;
        if (mousePos.y < @as(f32, @floatFromInt(self.y))) return;
        if (mousePos.x > @as(f32, @floatFromInt(self.x + self.width))) return;
        if (mousePos.y > @as(f32, @floatFromInt(self.y + self.height))) return;
        self.callback();
    }
}

pub fn draw(self: *@This()) void {
    raylib.DrawRectangle(@intCast(self.x), @intCast(self.y), @intCast(self.width), @intCast(self.height), raylib.BLACK);
    raylib.DrawRectangle(@intCast(self.x), @intCast(self.y), @intCast(self.width - 2), @intCast(self.height - 2), self.color);
    raylib.DrawText(self.text, @intCast(self.x), @intCast(self.y), @intCast(self.height / 2), raylib.BLACK);
}
