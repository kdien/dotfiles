vim.o.background = os.getenv('TERMINAL_THEME') or 'dark'

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
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
      local custom_ft = function()
        if vim.bo.filetype == 'yaml' then
          local schema = require('yaml-companion').get_buf_schema(0)
          if schema.result[1].name == 'none' then
            return 'yaml'
          else
            return 'yaml.' .. schema.result[1].name
          end
        else
          return vim.bo.filetype
        end
      end

      require('lualine').setup({
        options = {
          theme = vim.o.background == 'dark' and 'onedark' or 'onelight',
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
              path = 1,
            },
          },
          lualine_x = {
            custom_ft,
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
