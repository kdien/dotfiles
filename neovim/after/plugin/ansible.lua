local set_ansible = function()
  vim.lsp.stop_client(vim.lsp.get_active_clients({name = 'yamlls'}))
  vim.opt.filetype = 'ansible'
  vim.opt.syntax = 'yaml.ansible'
end

vim.keymap.set('n', '<leader>ab', set_ansible)

