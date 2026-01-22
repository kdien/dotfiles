vim.o.background = os.getenv('TERMINAL_THEME') or 'dark'

return {
  {
    'tjdevries/colorbuddy.nvim',
  },

  {
    'tomasiser/vim-code-dark',
    enabled = vim.o.background == 'dark' and true or false,

    config = function()
      vim.g.codedark_conservative = 1
      vim.cmd('colorscheme codedark')
      vim.cmd('highlight! link NormalFloat Pmenu')
    end,
  },

  {
    'projekt0n/github-nvim-theme',
    enabled = vim.o.background == 'light' and true or false,

    config = function()
      require('github-theme').setup({
        options = {
          transparent = true,
          hide_nc_statusline = false,
          dim_inactive = true,
        },
        groups = {
          all = {
            DiagnosticUnderlineError = { style = 'underline' },
            DiagnosticUnderlineWarn = { style = 'underline' },
            DiagnosticUnderlineInfo = { style = 'underline' },
            DiagnosticUnderlineHint = { style = 'underline' },
          },
          github_light = {
            NormalFloat = { fg = '#1f2328', bg = '#f6f8fa' },
            FloatBorder = { fg = '#1f2328', bg = '#f6f8fa' },
            StatusLineNC = { fg = '#f6f8fa', bg = '#96beee' },
          },
        },
      })
      vim.cmd('colorscheme github_light')
    end,
  },

  {
    'navarasu/onedark.nvim',
    enabled = false,

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
      require('onedark').load()
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
