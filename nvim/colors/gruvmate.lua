require('colorbuddy').colorscheme('gruvmate')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

Color.new('white', '#d9d9d9')
Color.new('red', '#cc6666')
Color.new('pink', '#fef601')
Color.new('green', '#99cc99')
Color.new('yellow', '#f8fe7a')
Color.new('blue', '#81a2be')
Color.new('aqua', '#8ec07c')
Color.new('cyan', '#8abeb7')
Color.new('purple', '#8e6fbd')
Color.new('violet', '#b294bb')
Color.new('orange', '#de935f')
Color.new('brown', '#a3685a')

Color.new('seagreen', '#698b69')
Color.new('turquoise', '#698b69')
Color.new('lightgrey', '#878887')

local background_string = '#282c34'
Color.new('background', background_string)
Color.new('grey0', background_string)
Color.new('float', '#393f4a')

Group.new('Normal', c.white, c.grey0)
Group.new('NormalFloat', c.white, c.float)
Group.new('FloatBorder', c.white, c.float)
Group.new('SignColumn', c.lightgrey, c.none)
Group.new('LineNr', c.lightgrey, c.none)

Group.new('@constant', c.orange, nil, s.none)
Group.new('@function', c.yellow, nil, s.none)
Group.new('@function.bracket', g.Normal, g.Normal)
Group.new('@keyword', c.violet, nil, s.none)
Group.new('@keyword.faded', g.nontext.fg:light(), nil, s.none)
Group.new('@property', c.blue)
Group.new('@variable', c.superwhite, nil)
Group.new('@variable.builtin', c.purple:light():light(), g.Normal)
