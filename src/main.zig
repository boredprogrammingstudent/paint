const raylib = @import("c.zig").raylib;
const Matrix = @import("matrix.zig");
const Assets = @import("assets.zig");
const Window = @import("window.zig");
const Scene = @import("scene.zig");
const DrawingInterface = @import("drawing_interface.zig");
const MainMenu = @import("main_menu.zig");

pub fn main() !void {
    const window: Window = .{ .width = 1920, .height = 1080 };
    raylib.InitWindow(window.width, window.height, "paint");
    defer raylib.CloseWindow();

    var assets: Assets = .{};
    try assets.load();
    defer assets.unload();

    var curr: u8 = 0;
    const main_menu = MainMenu.init(&curr, &window);
    const drawing_interface = DrawingInterface.init();

    const scenes: [2]Scene = .{ main_menu.scene, drawing_interface.scene };

    while (!raylib.WindowShouldClose()) {
        scenes[curr].update(&window, &assets);
        raylib.BeginDrawing();
        defer raylib.EndDrawing();
        scenes[curr].draw(&window, &assets);
    }
    try @import("tga.zig").encode(drawing_interface.getMatrix());
}
