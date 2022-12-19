vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

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
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Delete into void register
vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]])

-- Don't do anything when pressing Q in normal mode
vim.keymap.set('n', 'Q', '<nop>')

-- Set Ansible filetype
vim.keymap.set('n', '<leader>ab', ':set filetype=yaml.ansible<CR>')

