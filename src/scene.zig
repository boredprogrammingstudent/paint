const Window = @import("window.zig");
const Assets = @import("assets.zig");
vtable: *const VTable,
pub fn draw(self: *const @This(), window: *const Window, assets: *Assets) void {
    self.vtable.draw(window, assets);
}
pub fn update(self: *const @This(), window: *const Window, assets: *Assets) void {
    self.vtable.update(window, assets);
}
const VTable = struct { update: *const fn (*const Window, *Assets) void, draw: *const fn (*const Window, *Assets) void };
