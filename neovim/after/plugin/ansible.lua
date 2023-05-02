local set_ansible = function()
  vim.cmd('LspStop')
  vim.opt.filetype = 'yaml.ansible'
  vim.cmd('LspStart ansiblels')
  vim.opt.filetype = 'ansible'
  vim.opt.syntax = 'yaml.ansible'
end
vim.keymap.set('n', '<leader>ab', set_ansible)

