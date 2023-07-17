require('neodev').setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'ansiblels',
  'bashls',
  'dockerls',
  'gopls', -- Golang
  'jsonls',
  'lua_ls',
  'marksman', -- Markdown
  'omnisharp', -- C#/.NET
  'pyright', -- Python
  'rust_analyzer',
  'terraformls',
  'tsserver',
  'yamlls'
})

require('lspconfig').ansiblels.setup({
  filetypes = {
    "ansible"
  }
})

require('lspconfig').terraformls.setup({
  filetypes = {
    "terraform"
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  require('custom-lsp.keymaps')
end)

lsp.setup()

local diag_text = function(diagnostic)
  local sev_text
  if diagnostic.severity == vim.diagnostic.severity.ERROR then
    sev_text = 'ERROR'
  elseif diagnostic.severity == vim.diagnostic.severity.WARN then
    sev_text = 'WARN'
  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    sev_text = 'INFO'
  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
    sev_text = 'HINT'
  end
  return sev_text .. ': ' .. diagnostic.message
end

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    spacing = 6
  },
  signs = false,
  float = {
    header = '',
    border = 'single',
    format = function(diagnostic)
      return diag_text(diagnostic)
    end
  }
})

