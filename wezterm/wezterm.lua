local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

local platform = 'linux'
local home = require('os').getenv('HOME')
if not home then
  platform = 'win'
elseif string.match(home, '^/Users') then
  platform = 'mac'
end

local config = {}

config.automatically_reload_config = true

if platform == 'win' then
  config.default_prog = { 'wsl.exe', '--cd', '~' }
end

if platform ~= 'win' then
  config.window_decorations = 'RESIZE'
end

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.colors = require('colors')

config.default_cursor_style = 'SteadyBlock'

config.font = wezterm.font({
  family = 'Fira Code',
  weight = 'Regular',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', 'ss01' } -- disable ligatures
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = 'Fira Code',
      weight = 'Medium'
    })
  }
}

config.bold_brightens_ansi_colors = false

config.font_size = platform == 'mac' and 15.0 or 11.5

config.line_height = 1.1

local padding = {}
padding['left'] = platform == 'mac' and 8 or 4
padding['right'] = platform == 'mac' and 8 or 4
padding['top'] = platform == 'mac' and 8 or 4
padding['bottom'] = platform == 'mac' and 8 or 4

config.window_padding = padding

config.selection_word_boundary = ' \t\n;,\'"'

return config
