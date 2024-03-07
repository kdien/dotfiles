return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
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
          local git_root = vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
          require('telescope.builtin').find_files({ cwd = git_root, no_ignore = true })
        end,
      },

      {
        '<leader>sg',
        function()
          require('telescope.builtin').git_files({ show_untracked = true })
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
        },
      })
    end,
  },
}
