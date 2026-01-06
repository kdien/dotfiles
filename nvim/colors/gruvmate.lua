require('colorbuddy').colorscheme('gruvmate')

local colorbuddy = require('colorbuddy')
local Color = colorbuddy.Color
local Group = colorbuddy.Group
local c = colorbuddy.colors
local g = colorbuddy.groups
local s = colorbuddy.styles

Color.new('white', '#cccccc')
Color.new('red', '#cc6666')
Color.new('pink', '#fef601')
Color.new('green', '#99cc99')
Color.new('yellow', '#dfe46d')
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

Color.new('background', '#282c34')
Color.new('float', '#393f4a')
Color.new('diff_add', '#303d27')
Color.new('diff_delete', '#3c2729')

Group.new('Normal', c.white, c.background)
Group.new('NormalFloat', c.white, c.float)
Group.new('FloatBorder', c.white, c.float)
Group.new('SignColumn', c.lightgrey, c.none)
Group.new('LineNr', c.lightgrey, c.none)
Group.new('Comment', c.lightgrey, c.none)
Group.new('DiffAdd', c.none, c.diff_add)
Group.new('DiffDelete', c.none, c.diff_delete)

Group.new('@constant', c.orange, nil, s.none)
Group.new('@function', c.yellow, nil, s.none)
Group.new('@function.bracket', g.Normal, g.Normal)
Group.new('@keyword', c.violet, nil, s.none)
Group.new('@keyword.faded', g.nontext.fg:light(), nil, s.none)
Group.new('@property', c.blue)
Group.new('@variable', c.white, nil)
Group.new('@variable.builtin', c.purple:light():light(), g.Normal)
