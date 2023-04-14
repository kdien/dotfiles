vim.keymap.set('n', '<leader>tfm', '<Cmd>!terraform fmt %<CR><CR>')
vim.keymap.set('n', '<leader>yrs', 'ma<Cmd>?^resource<CR>yy`a<Cmd>delmarks a<CR>')
vim.keymap.set('n', '<leader>tft', '<Cmd>%s/^resource "\\(.*\\)" "\\(.*\\)".*/-target \\1.\\2 /<CR>')

