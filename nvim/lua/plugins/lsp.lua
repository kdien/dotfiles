return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      { 'mason-org/mason.nvim', version = '^1.0.0' },
      { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
    },

    config = function()
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('blink.cmp').get_lsp_capabilities())

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
          vim.keymap.set('n', 'K', vim.lsp.buf.hover)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references)
          vim.keymap.set('n', '<leader>vw', vim.lsp.buf.workspace_symbol)
          vim.keymap.set('n', '<leader>vs', vim.lsp.buf.document_symbol)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
          vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help)

          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end)
          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end)

          vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
          vim.keymap.set({ 'i', 's' }, '<C-f>', "<Cmd>lua require('luasnip').jump(1)<CR>")
          vim.keymap.set({ 'i', 's' }, '<C-b>', "<Cmd>lua require('luasnip').jump(-1)<CR>")
        end,
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
          'marksman', -- Markdown
          'omnisharp', -- C#/.NET
          'pyright', -- Python
          'regal',
          'ruff', -- Python
          'rust_analyzer',
          'taplo', -- TOML
          'terraformls',
          'ts_ls',
          'yamlls',
        },

        handlers = {
          default_setup,

          ansiblels = function()
            lspconfig.ansiblels.setup({
              filetypes = { 'ansible' },
            })
          end,

          gopls = function()
            lspconfig.gopls.setup({
              settings = {
                gopls = {
                  gofumpt = true,
                  buildFlags = { '-tags=integration' },
                },
              },
            })
          end,

          lua_ls = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  workspace = { checkThirdParty = false },

                  completion = {
                    callSnippet = 'Replace',
                  },

                  diagnostics = {
                    disable = { 'missing-fields' },
                  },
                },
              },
            })
          end,

          ruff = function()
            lspconfig.ruff.setup({
              cmd = { 'true' },
            })
          end,

          terraformls = function()
            lspconfig.terraformls.setup({
              filetypes = { 'terraform' },
            })
          end,

          yamlls = function()
            local cfg = require('yaml-companion').setup({
              schemas = {
                {
                  name = 'Argo',
                  uri = 'https://raw.githubusercontent.com/argoproj/argo-workflows/main/api/jsonschema/schema.json',
                },
              },
            })
            lspconfig.yamlls.setup(cfg)
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
          spacing = 6,
        },
        signs = false,
      })
    end,
  },
}
