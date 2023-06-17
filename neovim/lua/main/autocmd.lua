vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      timeout = 100
    })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ansible,hcl,lua,terraform,vim,yaml',
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  command = 'set noexpandtab'
})

