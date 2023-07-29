local telescope = require('telescope')
local actions = require('telescope.actions')
local grep_args = { '--hidden', '--glob', '!**/.git/*' }

telescope.setup {
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
vim.keymap.set('n', '<leader>sr', builtin.resume, {})
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})

vim.keymap.set('n', '<leader>sa', function()
  local git_root = vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
  builtin.find_files({ cwd = git_root, no_ignore = true })
end, {})

vim.keymap.set('n', '<leader>sg', function()
  builtin.git_files({ show_untracked = true })
end, {})

vim.keymap.set('n', '<leader>ss', builtin.live_grep, {})
vim.keymap.set('n', '<leader>st', builtin.grep_string, {})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>km', builtin.keymaps, {})

vim.keymap.set('n', '<leader>ls', function()
  builtin.buffers({ sort_lastused = true })
end, {})

vim.keymap.set('n', '<leader>di', builtin.diagnostics, {})
