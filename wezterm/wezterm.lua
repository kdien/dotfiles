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

local font_family = 'MesloLGM Nerd Font'

config.font = wezterm.font({
  family = font_family,
  weight = string.match(font_family, 'JetBrains') and 'Light' or 'Regular'
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = font_family,
      weight = (string.match(font_family, 'Fira') or string.match(font_family, 'JetBrains')) and 'Medium' or 'Bold'
    })
  }
}

if string.match(font_family, 'Fira') then
  config.line_height = 1.1
elseif string.match(font_family, 'Bitstr') then
  config.line_height = 1.15
end

if string.match(font_family, 'Fira ?Code') then
  config.font_size = platform == 'mac' and 14.5 or 11.0
else
  config.font_size = platform == 'mac' and 15.0 or 11.5
end

config.bold_brightens_ansi_colors = false
config.freetype_load_flags = 'NO_HINTING'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures

if string.match(font_family, 'Fira ?Code') then
  table.insert(config.harfbuzz_features, 'zero')
  table.insert(config.harfbuzz_features, 'ss03') -- &
  table.insert(config.harfbuzz_features, 'ss05') -- @
end

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
