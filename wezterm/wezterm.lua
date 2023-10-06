local wezterm = require('wezterm')
local mux = wezterm.mux

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

wezterm.on('toggle-ligatures', function(window)
  local overrides = window:get_config_overrides() or {}
  if not overrides.harfbuzz_features then
    overrides.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
  else
    overrides.harfbuzz_features = nil
  end
  window:set_config_overrides(overrides)
end)

local platform = 'linux'
local home = require('os').getenv('HOME')
if not home then
  platform = 'win'
elseif string.match(home, '^/Users') then
  platform = 'mac'
end

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.automatically_reload_config = true

if platform == 'win' then
  config.default_prog = { 'wsl.exe', '--cd', '~' }
end

if platform ~= 'win' then
  config.window_decorations = 'RESIZE'
end

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.enable_scroll_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.colors = require('colors')

config.default_cursor_style = 'SteadyBlock'

config.font = wezterm.font({
  family = 'Meslo LG M',
  weight = 'Regular'
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = 'Meslo LG M',
      weight = 'Bold'
    })
  }
}

config.font_size = platform == 'mac' and 15.0 or 11.5
-- config.line_height = 1.15
config.bold_brightens_ansi_colors = false
config.freetype_load_flags = 'NO_HINTING'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures

local padding = {}
padding['left'] = platform == 'mac' and 8 or 4
padding['right'] = platform == 'mac' and 8 or 4
padding['top'] = platform == 'mac' and 8 or 4
padding['bottom'] = platform == 'mac' and 8 or 4

config.window_padding = padding

config.selection_word_boundary = ' \t\n;,\'"'

config.keys = {
  {
    key = 'L',
    mods = 'CTRL',
    action = wezterm.action.EmitEvent('toggle-ligatures')
  }
}

return config
