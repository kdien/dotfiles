local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local platform = 'linux'
local home = require('os').getenv('HOME') or ''
if string.match(home, '^/Users') then
  platform = 'mac'
end

local config = {}

config.automatically_reload_config = true

config.window_decorations = 'RESIZE'
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.colors = require('colors')

config.default_cursor_style = 'SteadyBlock'

local fonts = {}
table.insert(fonts, platform == 'mac' and 'SF Mono' or 'SFMono')
table.insert(fonts, 'Menlo')
table.insert(fonts, 'Consolas')
table.insert(fonts, 'monospace')

config.font = wezterm.font_with_fallback(fonts)

config.font_size = platform == 'mac' and 15.0 or 11.5

config.line_height = 1.15

local padding = {}
padding['left'] = platform == 'mac' and 8 or 4
padding['right'] = platform == 'mac' and 8 or 4
padding['top'] = platform == 'mac' and 8 or 4
padding['bottom'] = platform == 'mac' and 8 or 4

config.window_padding = padding

config.selection_word_boundary = ' \t\n;,\'"'

return config
