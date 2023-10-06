return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Neovim config
      'folke/neodev.nvim'
    },

    config = function()
      require('neodev').setup()

      local lsp = require('lsp-zero')
      local lspconfig = require('lspconfig')

      lsp.preset('recommended')

      lsp.ensure_installed({
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
      })

      lspconfig.ansiblels.setup({
        filetypes = {
          'ansible'
        }
      })

      lspconfig.terraformls.setup({
        filetypes = {
          'terraform'
        }
      })

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete()
      })

      -- disable completion with tab
      cmp_mappings['<Tab>'] = nil
      cmp_mappings['<S-Tab>'] = nil

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings
      })

      lsp.set_preferences({
        suggest_lsp_servers = false
      })

      lsp.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000
        },
        servers = {
          ['gopls'] = { 'go' },
          ['lua_ls'] = { 'lua' },
          ['rust_analyzer'] = { 'rust' },
          ['terraformls'] = { 'terraform' },
        }
      })

      lsp.on_attach(function()
        require('custom-lsp.keymaps')
      end)

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
          spacing = 6
        },
        signs = false,
        float = {
          header = '',
          border = 'single'
        }
      })
    end
  }
}
