vim.o.background = os.getenv('TERMINAL_THEME') or 'dark'

return {
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup({
        transparent = true,
      })
      vim.cmd([[
        colorscheme vague
        highlight Visual guifg=NONE guibg=#474e5d
        highlight NormalFloat guibg=#3d4148
        highlight FloatBorder guibg=#3d4148
        highlight StatusLine guibg=#434354
        highlight LspReferenceText guibg=#3f4653
        highlight Comment guifg=#6f6f86
        highlight DiagnosticUnderlineHint gui=underline
        highlight DiagnosticUnderlineInfo gui=underline
        highlight DiagnosticUnderlineWarn gui=underline
        highlight DiagnosticUnderlineError gui=underline
        highlight link BlinkCmpDoc BlinkCmpMenu
      ]])
    end,
  },

  {
    'navarasu/onedark.nvim',
    enabled = false,
    config = function()
      require('onedark').setup({
        style = 'dark',
        transparent = true,
        code_style = {
          comments = 'none',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
        colors = {
          grey = '#6c727e',
        },
        highlights = {
          ['FloatBorder'] = { bg = '#393f4a' },
          ['NormalFloat'] = { bg = '#393f4a' },
          ['Visual'] = { bg = '#474e5d' },
          ['WinSeparator'] = { fg = '#474e5d' },
        },
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
