local background = vim.go.background

return {
  {
    'projekt0n/github-nvim-theme',
    enabled = background == 'light' and true or false,
    config = function()
      require('github-theme').setup({
        options = {
          transparent = true,
        },
      })
      vim.cmd('colorscheme github_light')
    end,
  },

  {
    'navarasu/onedark.nvim',
    enabled = background == 'dark' and true or false,
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
