vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Resize windows
-- width
vim.keymap.set({'n', 'v'}, '<C-Up>', '5<C-w>>')
vim.keymap.set({'n', 'v'}, '<C-Down>', '5<C-w><')
-- height
vim.keymap.set({'n', 'v'}, '<C-S-Up>', '5<C-w>+')
vim.keymap.set({'n', 'v'}, '<C-S-Down>', '5<C-w>-')

-- Indent and unindent highlighted blocks
vim.keymap.set('v', '<S-TAB>', '<gv')
vim.keymap.set('v', '<TAB>', '>gv')

-- Move highlighted blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Center cursor vertically while <C-d> and <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Paste and keep the previously yanked content instead of what just got deleted
vim.keymap.set('x', '<leader>p', [["_dP]])

-- Yank into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+yg$]])

-- Delete into void register
vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]])

-- Don't do anything when pressing Q in normal mode
vim.keymap.set('n', 'Q', '<nop>')

-- Open new tmux window to the current working directory
vim.keymap.set('n', '<leader>term', '<Cmd>!tmux new-window -c ' .. vim.fn.getcwd() .. '<CR><CR>')

-- Move between buffers
vim.keymap.set('n', '<leader>.', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<leader>,', '<Cmd>bprevious<CR>')

