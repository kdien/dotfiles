vim.o.background = os.getenv('TERMINAL_THEME') or 'dark'

return {
  {
    'tjdevries/colorbuddy.nvim',
  },

  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = vim.o.background,
        transparent = true,
        code_style = {
          comments = 'none',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
        colors = {
          fg = '#d4d4d4',
          grey = '#6c727e',
        },
        highlights = vim.o.background == 'dark' and {
          ['FloatBorder'] = { bg = '#393f4a' },
          ['NormalFloat'] = { bg = '#393f4a' },
          ['Visual'] = { bg = '#474e5d' },
          ['WinSeparator'] = { fg = '#474e5d' },
        } or {},
        diagnostics = {
          undercurl = false,
        },
      })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    keys = {
      { '<leader>ti', '<Cmd>IBLToggle<CR>' },
    },

    config = function()
      require('ibl').setup({
        indent = {
          -- char = '┇'
          char = '┆',
        },
        scope = {
          enabled = false,
        },
      })
    end,
  },
}
