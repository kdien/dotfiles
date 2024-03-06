return {
  {
    'folke/neodev.nvim',
    lazy = true,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },

    config = function()
      require('neodev').setup()

      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
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
          'rust_analyzer',
          'taplo', -- TOML
          'terraformls',
          'tsserver',
          'yamlls',
        },

        handlers = {
          default_setup,

          ansiblels = function()
            lspconfig.ansiblels.setup({
              filetypes = { 'ansible' },
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

          terraformls = function()
            lspconfig.terraformls.setup({
              filetypes = { 'terraform' },
            })
          end,
        },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
          spacing = 6,
        },
        signs = false,
        float = {
          header = '',
          border = 'rounded',
        },
      })
    end,
  },
}
