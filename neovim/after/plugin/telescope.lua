local telescope = require('telescope')
local actions = require('telescope.actions')
local grep_args = { '--hidden', '--glob', '!**/.git/*' }

telescope.setup {
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
    },
    live_grep = {
      additional_args = function(opts)
        return grep_args
      end
    },
    grep_string = {
      additional_args = function(opts)
        return grep_args
      end
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ss', builtin.live_grep, {})
vim.keymap.set('n', '<leader>st', builtin.grep_string, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>km', builtin.keymaps, {})
vim.keymap.set('n', '<leader>ls', builtin.buffers, {})
vim.keymap.set('n', '<leader>di', builtin.diagnostics, {})

