local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local config = {}

config.automatically_reload_config = true

config.window_decorations = 'RESIZE'
config.enable_tab_bar = false
config.enable_scroll_bar = false

config.colors = require('colors')

config.default_cursor_style = 'SteadyBlock'

config.font = wezterm.font_with_fallback({
  'SFMono',
  'Menlo',
  'Consolas',
  'monospace',
})

config.font_size = 11.5

config.line_height = 1.15

config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

config.selection_word_boundary = ' \t\n;,\'"'

return config
