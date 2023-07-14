vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  command = 'silent !terraform fmt %'
})

vim.keymap.set('n', '<leader>yrs', 'ma<Cmd>?^resource<CR>yy`a<Cmd>delmarks a<CR>')
vim.keymap.set('n', '<leader>tft', '<Cmd>%s/^resource "\\(.*\\)" "\\(.*\\)".*/-target \\1.\\2 /<CR>')
