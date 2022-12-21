local set_ansible = function()
  vim.cmd('LspStop')
  vim.opt.filetype = 'ansible'
  vim.opt.syntax = 'yaml.ansible'
  vim.cmd('LspStart ansiblels')
end
vim.keymap.set('n', '<leader>ab', set_ansible)

