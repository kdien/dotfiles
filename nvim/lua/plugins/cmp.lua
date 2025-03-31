return {
  {
    'Saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter' },

    dependencies = {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
    },

    opts = {
      keymap = {
        preset = 'default',
        ['<C-u>'] = { 'scroll_documentation_up' },
        ['<C-d>'] = { 'scroll_documentation_down' },
      },
      completion = {
        menu = {
          auto_show = true,
          border = 'none',
          draw = {
            columns = {
              { 'label' },
              { 'kind_icon', 'kind', gap = 1 },
              { 'source_name' },
            },
            components = {
              source_name = {
                text = function(ctx)
                  return string.format('[%s]', ctx.source_name)
                end,
              },
            },
          },
        },
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = 'none',
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      sources = {
        default = {
          'lsp',
          'snippets',
          'path',
          'buffer',
        },
      },
      snippets = {
        preset = 'luasnip',
      },
      cmdline = {
        keymap = {
          preset = 'inherit',
          ['<C-n>'] = { 'select_next', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<C-y>'] = { 'accept', 'fallback' },
          ['<C-e>'] = { 'cancel', 'fallback' },
        },
      },
    },
  },
}
