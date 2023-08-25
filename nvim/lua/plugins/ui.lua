return {
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'dark',
        transparent = true,
        code_style = {
          comments = 'none',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        }
      })
      require('onedark').load()
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = {
            'mode'
          },
          lualine_b = {
            'branch',
            'diff',
            'diagnostics'
          },
          lualine_c = {
            {
              'filename',
              path = 3
            },
          },
          lualine_x = {
            'filetype',
            'fileformat'
          },
          lualine_y = {
            'location'
          },
          lualine_z = {
            'progress'
          }
        },
      })
      vim.opt.showmode = false
    end
  }
}
