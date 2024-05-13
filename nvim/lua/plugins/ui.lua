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
      })
      require('onedark').load()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      require('lualine').setup({
        options = {
          theme = background == 'dark' and 'onedark' or 'onelight',
          component_separators = '|',
          section_separators = '',
          icons_enabled = false,
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            {
              'branch',
              icons_enabled = true,
            },
            'diff',
            {
              'diagnostics',
              symbols = {
                error = 'E:',
                warn = 'W:',
                info = 'I:',
                hint = 'H:',
              },
            },
          },
          lualine_c = {
            {
              'filename',
              path = 3,
            },
          },
          lualine_x = {
            'filetype',
            {
              'fileformat',
              symbols = {
                dos = 'dos',
                unix = 'unix',
              },
            },
          },
          lualine_y = {
            'location',
          },
          lualine_z = {
            'progress',
          },
        },
      })
      vim.opt.showmode = false
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
