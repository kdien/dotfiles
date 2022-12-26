vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ansible,lua,terraform,vim,yaml',
  command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  command = 'set textwidth=0'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = vim.fn.expand '$HOME/.ssh/config.d/*',
  command = 'set filetype=sshconfig'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = vim.fn.expand 'Jenkinsfile*',
  command = 'set filetype=groovy'
})

