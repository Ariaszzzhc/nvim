local options = {
  neovide_refresh_rate = 140,
  -- neovide_transparency = 0.8,
  neovide_no_idle = true,
  neovide_remember_window_size = true,
  neovide_cursor_animation_length = 0.13,
  neovide_cursor_trail_length = 0.8,
  neovide_cursor_antialiasing = true,
  neovide_cursor_vfx_mode = "railgun",
}

for k, v in pairs(options) do
  vim.g[k] = v
end
