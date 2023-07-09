vim.opt.expandtab = false

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  command = 'silent !gofmt -w %'
})
