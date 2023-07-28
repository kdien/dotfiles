local augroup = vim.api.nvim_create_augroup('UserGroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'ansible,hcl,lua,terraform,vim,yaml',
  command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = vim.fn.expand('$HOME/.ssh/config.d/*'),
  command = 'set filetype=sshconfig'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = vim.fn.expand 'Jenkinsfile*',
  command = 'set filetype=groovy'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = augroup,
  pattern = 'terraform.tfvars',
  command = 'set filetype=terraform'
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.tf',
  command = 'silent !terraform fmt %'
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.go',
  command = 'silent !gofmt -w %'
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.rust',
  command = 'silent !rustfmt %'
})
