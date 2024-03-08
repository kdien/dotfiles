return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },

    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',

      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },

    config = function()
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'path' },
          { name = 'buffer', keyword_length = 3 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = {
            'abbr',
            'kind',
            'menu',
          },
          format = function(entry, item)
            local short_name = {
              nvim_lsp = 'LSP',
              nvim_lua = 'nvim',
            }
            local menu_name = short_name[entry.source.name] or entry.source.name
            item.menu = string.format('[%s]', menu_name)
            return item
          end,
        },
      })
    end,
  },
}
