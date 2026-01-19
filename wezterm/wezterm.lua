local wezterm = require('wezterm')
local mux = wezterm.mux
local getenv = require('os').getenv

wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

wezterm.on('format-window-title', function()
  return 'WezTerm'
end)

local platform = 'linux'
local home = getenv('HOME')
if not home then
  platform = 'win'
elseif string.match(home, '^/Users') then
  platform = 'mac'
end

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.max_fps = 120
config.animation_fps = 1
config.front_end = 'OpenGL'
config.webgpu_power_preference = 'HighPerformance'
config.prefer_egl = true

config.automatically_reload_config = true
config.audible_bell = 'Disabled'

if platform == 'win' then
  if #wezterm.default_wsl_domains() > 0 then
    config.default_prog = { 'wsl.exe', '--cd', '~' }
  else
    config.default_prog = { 'pwsh.exe', '-WorkingDirectory', '~' }
  end
end

if platform == 'mac' then
  config.window_decorations = 'RESIZE'
end

local desktop = getenv('XDG_CURRENT_DESKTOP') or ''
if platform == 'linux' and string.match(desktop, 'GNOME') then
  config.window_decorations = getenv('XDG_SESSION_TYPE') == 'wayland' and 'RESIZE' or 'NONE'
end

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.enable_scroll_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.colors = require('colors.default')

config.default_cursor_style = 'SteadyBlock'

local font = 'Meslo LG M'

config.font = wezterm.font({
  family = font,
  weight = 'Regular',
})

config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font({
      family = font,
      weight = 'Regular',
    }),
  },
}

config.font_size = platform == 'mac' and 15.0 or 11.25
-- config.line_height = 1.1
config.bold_brightens_ansi_colors = false
config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = 'Light'
config.freetype_render_target = 'HorizontalLcd'
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } -- disable ligatures

local padding = platform == 'mac' and 8 or 4
config.window_padding = {
  left = padding,
  right = padding,
  top = padding,
  bottom = padding,
}

config.selection_word_boundary = ' \t\n;,\'"'

config.keys = {}

if platform == 'win' then
  table.insert(config.keys, {
    key = 'p',
    mods = 'CTRL|ALT',
    action = wezterm.action.SpawnCommandInNewTab({
      args = { 'pwsh.exe', '-WorkingDirectory', '~' },
    }),
  })
end

return config
