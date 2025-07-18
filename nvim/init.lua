require('main.opt')
require('main.keymaps')
require('main.lazy')
require('main.autocmd')
require('main.statusline')

vim.cmd('colorscheme onedark')

-- Disable LSP semantic token highlighting
for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
  vim.api.nvim_set_hl(0, group, {})
end
