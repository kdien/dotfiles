local tlsp_builtin = require('telescope.builtin')

vim.keymap.set('n', 'gd', tlsp_builtin.lsp_definitions)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>vws', tlsp_builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>vrr', tlsp_builtin.lsp_references)
vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename)
vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help)

