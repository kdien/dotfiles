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

      local lsp_servers = {
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
      }

      require('mason-lspconfig').setup({ ensure_installed = lsp_servers })

      local custom_configs = {
        ansiblels = {
          filetypes = { 'ansible' },
        },

        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              buildFlags = { '-tags=integration' },
            },
          },
        },

        lua_ls = {
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
        },

        ruff = {
          cmd = { 'true' },
        },

        terraformls = {
          filetypes = { 'terraform' },
        },

        yamlls = require('yaml-companion').setup({}),
      }

      for _, s in ipairs(lsp_servers) do
        if custom_configs[s] ~= nil then
          vim.lsp.config(s, custom_configs[s])
        end
      end

      vim.lsp.enable(lsp_servers)
      vim.lsp.semantic_tokens.enable(false)

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
