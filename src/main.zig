const raylib = @import("c.zig").raylib;
const Matrix = @import("matrix.zig");
const Assets = @import("assets.zig");
const Window = @import("window.zig");
const Scene = @import("scene.zig");
const DrawingInterface = @import("drawing_interface.zig");
pub fn main() !void {
    const window: Window = .{ .width = 1920, .height = 1080 };
    raylib.InitWindow(window.width, window.height, "paint");
    defer raylib.CloseWindow();

    var assets: Assets = .{};
    try assets.load();
    defer assets.unload();

    const drawing_interface = DrawingInterface.init();

    while (!raylib.WindowShouldClose()) {
        drawing_interface.scene.update(&window, &assets);
        raylib.BeginDrawing();
        defer raylib.EndDrawing();
        drawing_interface.scene.draw(&window, &assets);
    }
    try @import("tga.zig").encode(drawing_interface.getMatrix());
}
