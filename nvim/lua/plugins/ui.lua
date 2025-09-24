vim.o.background = os.getenv('TERMINAL_THEME') or 'dark'

return {
  {
    'tjdevries/colorbuddy.nvim',
  },

  {
    'Mofiqul/vscode.nvim',
    opts = {
      group_overrides = {
        ModeMsg = { bg = 'NONE' },
        StatusLine = { bg = '#c9c9c9' },
        StatusLineNC = { bg = '#dfdfdf' },
      },
    },
  },

  {
    'maxmx03/solarized.nvim',
    opts = {
      transparent = {
        enabled = true,
        normalfloat = false,
      },
      on_highlights = function(colors, color)
        local groups = {
          Visual = { fg = 'NONE' },
          FloatBorder = { bg = colors.base04 },
          TreeSitterContext = { bg = '#1a404b' },
        }
        return groups
      end,
    },
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
        colors = vim.o.background == 'dark' and {
          fg = TERM_FG_COLOR or '#abb2bf',
          grey = '#6c727e',
        } or {},
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
