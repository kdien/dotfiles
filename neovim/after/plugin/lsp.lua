local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'ansiblels',
  'bashls',
  'csharp_ls',
  'dockerls',
  'jedi_language_server', -- Python
  'jsonls',
  'marksman', -- Markdown
  'omnisharp',
  'omnisharp_mono',
  'powershell_es',
  'sumneko_lua',
  'terraformls',
  'tsserver',
  'yamlls'
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

require('user-lsp.cmp')
lsp.setup_nvim_cmp({
  mapping = CMP_MAPPINGS
})

lsp.set_preferences({
  suggest_lsp_servers = false,
})

lsp.on_attach(function(client, bufnr)
  require('user-lsp.keymaps')
end)

lsp.setup()

local sev_text = function(diagnostic)
  if diagnostic.severity == vim.diagnostic.severity.ERROR then
    return 'ERROR'
  elseif diagnostic.severity == vim.diagnostic.severity.WARN then
    return 'WARN'
  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    return 'INFO'
  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
    return 'HINT'
  end
end
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
  float = {
    header = '',
    border = 'single',
    format = function(diagnostic)
      return string.format(
        '%s - %s: %s',
        sev_text(diagnostic),
        diagnostic.code,
        diagnostic.message
      )
    end
  }
})

