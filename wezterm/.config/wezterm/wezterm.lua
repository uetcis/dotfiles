local wezterm = require 'wezterm'

return {
  font = wezterm.font 'Sarasa Mono CL',
  default_cursor_style = 'BlinkingBar',
  font_size = 12.0,
  color_scheme = 'nord',
  --	enable_wayland = false,
  --	front_end = 'WebGpu',
  -- window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  use_ime = false,
  warn_about_missing_glyphs = false,
}
