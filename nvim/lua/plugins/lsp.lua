return {
  {
    'folke/neodev.nvim',
    lazy = true
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim'
    },

    config = function()
      require('neodev').setup()

      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
          require('main.custom-lsp').set_keymaps()
          require('main.custom-lsp').format_on_save()
        end
      })

      require('mason').setup({})

      local default_setup = function(server)
        lspconfig[server].setup({})
      end

      require('mason-lspconfig').setup({
        ensure_installed = {
          'ansiblels',
          'bashls',
          'dockerls',
          'gopls', -- Golang
          'jsonls',
          'lua_ls',
          'marksman',  -- Markdown
          'omnisharp', -- C#/.NET
          'pyright',   -- Python
          'rust_analyzer',
          'terraformls',
          'tsserver',
          'yamlls'
        },

        handlers = {
          default_setup,

          ansiblels = function()
            lspconfig.ansiblels.setup({
              filetypes = { 'ansible' }
            })
          end,

          lua_ls = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    disable = { 'missing-fields' }
                  }
                }
              }
            })
          end,

          terraformls = function()
            lspconfig.terraformls.setup({
              filetypes = { 'terraform' }
            })
          end
        }
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
      )

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
      )

      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
          spacing = 6
        },
        signs = false,
        float = {
          header = '',
          border = 'rounded'
        }
      })
    end
  }
}
