local git_root = function()
  return vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
end

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',

    keys = {
      { '<leader>sr', '<Cmd>Telescope resume<CR>' },
      { '<leader>sf', '<Cmd>Telescope find_files<CR>' },
      { '<leader>ss', '<Cmd>Telescope live_grep<CR>' },
      { '<leader>st', '<Cmd>Telescope grep_string<CR>' },
      { '<leader>sh', '<Cmd>Telescope help_tags<CR>' },
      { '<leader>km', '<Cmd>Telescope keymaps<CR>' },
      { '<leader>di', '<Cmd>Telescope diagnostics<CR>' },

      {
        '<leader>sa',
        function()
          require('telescope.builtin').find_files({ cwd = git_root(), no_ignore = true })
        end,
      },

      {
        '<leader>sg',
        function()
          require('telescope.builtin').git_files({ show_untracked = true })
        end,
      },

      {
        '<leader>sp',
        function()
          require('telescope.builtin').live_grep({ cwd = git_root() })
        end,
      },

      {
        '<leader>ls',
        function()
          require('telescope.builtin').buffers({ sort_lastused = true })
        end,
      },

      {
        '<leader>sn',
        function()
          require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config'), no_ignore = true })
        end,
      },
    },

    config = function()
      require('telescope').setup({
        defaults = {
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { '--hidden', '--glob', '!**/.git/*' }
            end,
          },
          grep_string = {
            additional_args = function()
              return { '--hidden', '--glob', '!**/.git/*' }
            end,
          },
          buffers = {
            mappings = {
              n = {
                ['d'] = require('telescope.actions').delete_buffer,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require('telescope').load_extension('fzf')
    end,
  },
}
