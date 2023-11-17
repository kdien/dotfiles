return {
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'dark',
        transparent = true,
        code_style = {
          comments = 'italic',
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
        options = {
          component_separators = '|',
          section_separators = '',
          icons_enabled = false
        },
        sections = {
          lualine_a = {
            'mode'
          },
          lualine_b = {
            {
              'branch',
              icons_enabled = true
            },
            'diff',
            {
              'diagnostics',
              symbols = {
                error = 'E:',
                warn = 'W:',
                info = 'I:',
                hint = 'H:'
              },
            }
          },
          lualine_c = {
            {
              'filename',
              path = 3
            },
          },
          lualine_x = {
            'filetype',
            {
              'fileformat',
              symbols = {
                dos = 'dos',
                unix = 'unix'
              }
            }
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
