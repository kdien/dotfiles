vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

-- Resize windows
-- width
vim.keymap.set({ 'n', 'v' }, '<M-Up>', '5<C-w>>')
vim.keymap.set({ 'n', 'v' }, '<M-Down>', '5<C-w><')
-- height
vim.keymap.set({ 'n', 'v' }, '<M-S-Up>', '5<C-w>+')
vim.keymap.set({ 'n', 'v' }, '<M-S-Down>', '5<C-w>-')

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
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+yg$]])

-- Delete into void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- Don't do anything when pressing Q in normal mode
vim.keymap.set('n', 'Q', '<nop>')

-- Open new tmux (split-)window to the current working directory
function SetTmuxKeymaps()
  vim.keymap.set('n', '<leader>term', '<Cmd>silent !tmux new-window -c "' .. vim.fn.getcwd() .. '"<CR>')
  vim.keymap.set('n', '<leader>sterm', '<Cmd>silent !tmux split-window -c "' .. vim.fn.getcwd() .. '"<CR>')
end

SetTmuxKeymaps()

-- Cycle through open buffers
vim.keymap.set('n', ']b', '<Cmd>bnext<CR>')
vim.keymap.set('n', '[b', '<Cmd>bprevious<CR>')
vim.keymap.set('n', '<leader>q', '<Cmd>b#<CR>')

-- Cycle through quickfix list items
vim.keymap.set('n', ']e', '<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>')
vim.keymap.set('n', '[e', '<Cmd>try | cprevious | catch | clast | catch | endtry<CR>')

-- Cycle through open tabs
vim.keymap.set('n', ']t', '<Cmd>tabnext<CR>')
vim.keymap.set('n', '[t', '<Cmd>tabprevious<CR>')

-- Change tab size
vim.keymap.set('n', '<leader>ts', function()
  vim.ui.input({ prompt = 'Update tab size: ' }, function(input)
    vim.opt_local.tabstop = tonumber(input)
    vim.opt_local.softtabstop = tonumber(input)
    vim.opt_local.shiftwidth = tonumber(input)
  end)
end)

-- Toggle winborder
vim.keymap.set('n', '<leader>wb', function()
  if vim.o.winborder == 'none' then
    vim.o.winborder = 'rounded'
  else
    vim.o.winborder = 'none'
  end
end)
