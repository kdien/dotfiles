local M = {}

function M.set_keymaps()
  vim.keymap.set('n', 'K', vim.lsp.buf.hover)
  vim.keymap.set('n', 'gd', '<Cmd>Telescope lsp_definitions<CR>')
  vim.keymap.set('n', 'go', '<Cmd>Telescope lsp_type_definitions<CR>')
  vim.keymap.set('n', 'gi', '<Cmd>Telescope lsp_implementations<CR>')
  vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<CR>')
  vim.keymap.set('n', '<leader>vw', '<Cmd>Telescope lsp_workspace_symbols<CR>')
  vim.keymap.set('n', '<leader>vs', '<Cmd>Telescope lsp_document_symbols<CR>')
  vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
  vim.keymap.set({ 'i', 's' }, '<C-f>', "<Cmd>lua require('luasnip').jump(1)<CR>")
  vim.keymap.set({ 'i', 's' }, '<C-b>', "<Cmd>lua require('luasnip').jump(-1)<CR>")
end

function M.format_on_save()
  vim.api.nvim_create_autocmd('BufWritePre', {
    desc = 'Auto-format on save with LSP',
    group = vim.api.nvim_create_augroup('format_on_save_lsp', { clear = true }),
    pattern = {
      '*.cs',
      '*.go',
      '*.java',
      '*.lua',
      '*.rs',
    },
    command = 'lua vim.lsp.buf.format({ async = false })'
  })

  vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Auto-format on save for Terraform',
    group = vim.api.nvim_create_augroup('format_on_save_tf', { clear = true }),
    pattern = {
      '*.tf',
      '*.tfvars',
    },
    command = 'silent !terraform fmt %'
  })

  vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Auto-format on save for Python using Black',
    group = vim.api.nvim_create_augroup('format_on_save_python_black', { clear = true }),
    pattern = '*.py',
    command = 'silent !black %'
  })
end

return M
