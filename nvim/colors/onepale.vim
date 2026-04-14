" One Pale
" A conservative colorscheme using the One Dark palette.
" Only a handful of colors are used; everything else is the terminal default.

scriptencoding utf-8

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="onepale"

" -----------
" Palette:
" -----------

if &t_Co >= 256
    let s:term256=1
elseif !exists("s:term256")
    let s:term256=0
endif

fun! <sid>hi(group, fg, bg, attr, sp)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . (s:term256 ? a:fg.cterm256 : a:fg.cterm)
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . (s:term256 ? a:bg.cterm256 : a:bg.cterm)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
  if !empty(a:sp)
    exec "hi " . a:group . " guisp=" . a:sp.gui
  endif
endfun

let s:none  = {'gui': 'NONE', 'cterm': 'NONE', 'cterm256': 'NONE'}
let s:front = s:none
let s:back  = s:none

" UI surfaces
let s:cursor_line = {'gui': '#2c313a', 'cterm': 'NONE', 'cterm256': '236'}
let s:selection   = {'gui': '#474e5d', 'cterm': 'NONE', 'cterm256': '239'}
let s:line_number = {'gui': '#4b5263', 'cterm': 'NONE', 'cterm256': '240'}
let s:popup_bg    = {'gui': '#393f4a', 'cterm': 'NONE', 'cterm256': '237'}
let s:popup_sel   = {'gui': '#073655', 'cterm': 'NONE', 'cterm256': '24'}
let s:split       = {'gui': '#3e4452', 'cterm': 'NONE', 'cterm256': '237'}
let s:tab_current = {'gui': '#393f4a', 'cterm': 'NONE', 'cterm256': '237'}
let s:tab_other   = {'gui': '#21252b', 'cterm': 'NONE', 'cterm256': '234'}

" Syntax (the few colors we actually use)
let s:blue   = {'gui': '#569cd6', 'cterm': '04', 'cterm256': '68'}
let s:green  = {'gui': '#98c379', 'cterm': '02', 'cterm256': '114'}
let s:orange = {'gui': '#d19a66', 'cterm': '03', 'cterm256': '173'}
let s:red    = {'gui': '#e06c75', 'cterm': '01', 'cterm256': '168'}
let s:cyan   = {'gui': '#56b6c2', 'cterm': '06', 'cterm256': '73'}
let s:purple = {'gui': '#c678dd', 'cterm': '05', 'cterm256': '176'}

" Diff
let s:diff_green  = {'gui': '#2a3429', 'cterm': 'NONE', 'cterm256': '22'}
let s:diff_red    = {'gui': '#3c2829', 'cterm': 'NONE', 'cterm256': '52'}
let s:diff_blue   = {'gui': '#1b2733', 'cterm': 'NONE', 'cterm256': '17'}
let s:diff_yellow = {'gui': '#3e3529', 'cterm': 'NONE', 'cterm256': '58'}
let s:search      = {'gui': '#3e4452', 'cterm': 'NONE', 'cterm256': '237'}
let s:search_cur  = {'gui': '#4b5263', 'cterm': 'NONE', 'cterm256': '240'}

" -------
" UI:
" -------

call <sid>hi('Normal',       s:front,       s:back,        'none', {})
call <sid>hi('ColorColumn',  {},            s:cursor_line, 'none', {})
call <sid>hi('Cursor',       s:back,        s:front,       'none', {})
call <sid>hi('CursorLine',   {},            s:none,        'none', {})
hi! link CursorColumn CursorLine
call <sid>hi('Directory',    s:blue,        s:none,        'none', {})
call <sid>hi('DiffAdd',      s:front,       s:diff_green,  'none', {})
call <sid>hi('DiffChange',   s:front,       s:diff_blue,   'none', {})
call <sid>hi('DiffDelete',   s:front,       s:diff_red,    'none', {})
call <sid>hi('DiffText',     s:front,       s:diff_yellow, 'none', {})
call <sid>hi('EndOfBuffer',  s:line_number, s:back,        'none', {})
call <sid>hi('ErrorMsg',     s:red,         s:back,        'none', {})
call <sid>hi('VertSplit',    s:split,       s:back,        'none', {})
hi! link WinSeparator VertSplit
call <sid>hi('Folded',       s:line_number, s:none,        'underline', {})
call <sid>hi('FoldColumn',   s:line_number, s:back,        'none', {})
call <sid>hi('SignColumn',   {},            s:back,        'none', {})
call <sid>hi('IncSearch',    s:none,        s:search_cur,  'none', {})
call <sid>hi('LineNr',       s:line_number, s:back,        'none', {})
call <sid>hi('CursorLineNr', s:front,       s:back,        'none', {})
call <sid>hi('MatchParen',   s:none,        s:selection,   'bold', {})
call <sid>hi('ModeMsg',      s:front,       s:none,        'none', {})
hi! link MoreMsg ModeMsg
call <sid>hi('NonText',      s:line_number, s:none,        'none', {})
call <sid>hi('Pmenu',        s:front,       s:popup_bg,    'none', {})
call <sid>hi('PmenuSel',     s:front,       s:popup_sel,   'none', {})
call <sid>hi('PmenuSbar',    {},            s:selection,   'none', {})
call <sid>hi('PmenuThumb',   {},            s:front,       'none', {})
call <sid>hi('Question',     s:blue,        s:back,        'none', {})
call <sid>hi('Search',       s:none,        s:search,      'none', {})
call <sid>hi('SpecialKey',   s:line_number, s:none,        'none', {})
call <sid>hi('StatusLine',   s:front,       s:tab_current, 'none', {})
call <sid>hi('StatusLineNC', s:line_number, s:cursor_line, 'none', {})
call <sid>hi('TabLine',      s:front,       s:tab_other,   'none', {})
call <sid>hi('TabLineFill',  s:front,       s:tab_other,   'none', {})
call <sid>hi('TabLineSel',   s:front,       s:tab_current, 'none', {})
call <sid>hi('Title',        s:none,        s:none,        'bold', {})
call <sid>hi('Visual',       s:none,        s:selection,   'none', {})
hi! link VisualNOS Visual
call <sid>hi('WarningMsg',   s:orange,      s:back,        'none', {})
call <sid>hi('WildMenu',     s:none,        s:selection,   'none', {})
hi! link NormalFloat Pmenu
hi! link FloatBorder Pmenu

" Legacy diff
hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete

" ----------------
" Syntax:
" ----------------
" The conservative principle: most things are foreground.
" Only keywords, strings, comments, and errors get color.

call <sid>hi('Comment',     s:orange, {}, 'none', {})
call <sid>hi('Constant',    s:front,  {}, 'none', {})
call <sid>hi('String',      s:green,  {}, 'none', {})
call <sid>hi('Character',   s:green,  {}, 'none', {})
call <sid>hi('Number',      s:front,  {}, 'none', {})
call <sid>hi('Boolean',     s:blue,   {}, 'none', {})
hi! link Float Number
call <sid>hi('Identifier',  s:front,  {}, 'none', {})
call <sid>hi('Function',    s:front,  {}, 'none', {})
call <sid>hi('Statement',   s:blue,   {}, 'none', {})
call <sid>hi('Conditional', s:blue,   {}, 'none', {})
call <sid>hi('Repeat',      s:blue,   {}, 'none', {})
call <sid>hi('Label',       s:blue,   {}, 'none', {})
call <sid>hi('Operator',    s:front,  {}, 'none', {})
call <sid>hi('Keyword',     s:blue,   {}, 'none', {})
call <sid>hi('Exception',   s:blue,   {}, 'none', {})
call <sid>hi('PreProc',     s:blue,   {}, 'none', {})
call <sid>hi('Include',     s:blue,   {}, 'none', {})
call <sid>hi('Define',      s:blue,   {}, 'none', {})
call <sid>hi('Macro',       s:blue,   {}, 'none', {})
call <sid>hi('PreCondit',   s:blue,   {}, 'none', {})
call <sid>hi('Type',        s:cyan,   {}, 'none', {})
call <sid>hi('StorageClass',s:cyan,   {}, 'none', {})
call <sid>hi('Structure',   s:cyan,   {}, 'none', {})
call <sid>hi('Typedef',     s:cyan,   {}, 'none', {})
call <sid>hi('Special',     s:front,  {}, 'none', {})
call <sid>hi('SpecialChar', s:front,  {}, 'none', {})
call <sid>hi('Tag',         s:front,  {}, 'none', {})
call <sid>hi('Delimiter',   s:front,  {}, 'none', {})
call <sid>hi('SpecialComment', s:green, {}, 'none', {})
call <sid>hi('Debug',       s:front,  {}, 'none', {})
call <sid>hi('Underlined',  s:none,   {}, 'underline', {})
call <sid>hi('Conceal',     s:front,  s:back, 'none', {})
call <sid>hi('Ignore',      s:back,   {},     'none', {})
call <sid>hi('Error',       s:red,    s:back, 'undercurl', s:red)
call <sid>hi('Todo',        s:none,   s:selection, 'none', {})
call <sid>hi('SpellBad',    s:red,    s:back, 'undercurl', s:red)
call <sid>hi('SpellCap',    s:red,    s:back, 'undercurl', s:red)
call <sid>hi('SpellRare',   s:red,    s:back, 'undercurl', s:red)
call <sid>hi('SpellLocal',  s:red,    s:back, 'undercurl', s:red)

" ----------------
" Diagnostics:
" ----------------

call <sid>hi('DiagnosticError', s:red,    {}, 'none', {})
call <sid>hi('DiagnosticWarn',  s:orange, {}, 'none', {})
call <sid>hi('DiagnosticInfo',  s:blue,   {}, 'none', {})
call <sid>hi('DiagnosticHint',  s:cyan,   {}, 'none', {})
call <sid>hi('DiagnosticUnderlineError', {}, {}, 'underline', s:red)
call <sid>hi('DiagnosticUnderlineWarn',  {}, {}, 'underline', s:orange)
call <sid>hi('DiagnosticUnderlineInfo',  {}, {}, 'underline', s:blue)
call <sid>hi('DiagnosticUnderlineHint',  {}, {}, 'underline', s:cyan)

" ----------------
" Treesitter:
" ----------------

if has("nvim")
    " Identifiers / variables / fields — all foreground
    hi! link @variable Normal
    hi! link @variable.builtin Normal
    hi! link @variable.parameter Normal
    hi! link @variable.member Normal
    hi! link @constant Normal
    hi! link @constant.builtin Constant
    hi! link @constant.macro Constant
    hi! link @property Normal
    hi! link @field Normal
    hi! link @parameter Normal

    " Functions — foreground
    hi! link @function Normal
    hi! link @function.builtin Normal
    hi! link @function.call Normal
    hi! link @function.macro Normal
    hi! link @method Normal
    hi! link @method.call Normal
    hi! link @constructor Normal

    " Keywords — blue
    hi! link @keyword Keyword
    hi! link @keyword.coroutine Keyword
    hi! link @keyword.function Keyword
    hi! link @keyword.operator Keyword
    hi! link @keyword.import Include
    hi! link @keyword.type Type
    hi! link @keyword.modifier Keyword
    hi! link @keyword.repeat Repeat
    hi! link @keyword.return Keyword
    hi! link @keyword.debug Keyword
    hi! link @keyword.exception Exception
    hi! link @keyword.conditional Conditional
    hi! link @keyword.directive Include
    hi! link @conditional Conditional
    hi! link @repeat Repeat
    hi! link @exception Exception
    hi! link @include Include
    hi! link @label Label

    " Types — cyan
    hi! link @type Type
    hi! link @type.builtin Type
    hi! link @type.definition Type
    hi! link @type.qualifier Type
    hi! link @attribute Normal
    hi! link @namespace Normal

    " Literals
    hi! link @string String
    hi! link @string.escape Special
    hi! link @string.regex String
    hi! link @string.special Special
    hi! link @character Character
    hi! link @number Number
    hi! link @boolean Boolean
    hi! link @float Float

    " Punctuation / operators — foreground
    hi! link @punctuation.bracket Normal
    hi! link @punctuation.delimiter Normal
    hi! link @punctuation.special Normal
    hi! link @operator Operator

    " Comments
    hi! link @comment Comment
    hi! link @comment.documentation Comment

    " Markup
    hi! link @markup.heading Title
    hi! link @markup.strong Normal
    hi! link @markup.italic Normal
    hi! link @markup.underline Underlined
    hi! link @markup.raw String
    hi! link @markup.link Underlined

    " Tags (HTML/XML)
    hi! link @tag Keyword
    hi! link @tag.attribute Normal
    hi! link @tag.delimiter Normal
endif

" ----------------
" Git:
" ----------------

call <sid>hi('gitcommitHeader',        s:line_number, {}, 'none', {})
call <sid>hi('gitcommitOnBranch',      s:line_number, {}, 'none', {})
call <sid>hi('gitcommitBranch',        s:blue,        {}, 'none', {})
call <sid>hi('gitcommitComment',       s:green,       {}, 'none', {})
call <sid>hi('gitcommitSelectedType',  s:green,       {}, 'none', {})
hi! link gitcommitSelectedFile gitcommitSelectedType
call <sid>hi('gitcommitDiscardedType', s:red,         {}, 'none', {})
hi! link gitcommitDiscardedFile gitcommitDiscardedType
hi! link gitcommitOverflow gitcommitDiscardedType
call <sid>hi('gitcommitSummary',       s:front,       {}, 'none', {})

" ----------------
" Markdown:
" ----------------

call <sid>hi('markdownH1',               s:blue,   {}, 'bold', {})
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
call <sid>hi('markdownHeadingDelimiter', s:blue,   {}, 'none', {})
call <sid>hi('markdownBold',             s:front,  {}, 'bold', {})
call <sid>hi('markdownRule',             s:blue,   {}, 'bold', {})
call <sid>hi('markdownCode',            s:orange,  {}, 'none', {})
hi! link markdownCodeDelimiter markdownCode
call <sid>hi('markdownUrl',              s:front,  {}, 'underline', {})
call <sid>hi('markdownLinkText',         s:orange, {}, 'none', {})
