local git_root = function()
  return vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
end

return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  keys = {
    { '<leader>sr', '<Cmd>FzfLua resume<CR>' },
    { '<leader>sf', '<Cmd>FzfLua files<CR>' },
    { '<leader>ss', '<Cmd>FzfLua live_grep<CR>' },
    { '<leader>st', '<Cmd>FzfLua grep_cword<CR>' },
    { '<leader>sh', '<Cmd>FzfLua help_tags<CR>' },
    { '<leader>km', '<Cmd>FzfLua keymaps<CR>' },
    { '<leader>di', '<Cmd>FzfLua diagnostics_document<CR>' },

    {
      '<leader>sa',
      function()
        require('fzf-lua').files({ cwd = git_root(), no_ignore = true })
      end,
    },

    {
      '<leader>sg',
      function()
        require('fzf-lua').git_files({ show_untracked = true })
      end,
    },

    {
      '<leader>sp',
      function()
        require('fzf-lua').live_grep({ cwd = git_root() })
      end,
    },

    {
      '<leader>ls',
      function()
        require('fzf-lua').buffers()
      end,
    },

    {
      '<leader>sn',
      function()
        require('fzf-lua').files({ cwd = vim.fn.stdpath('config'), no_ignore = true })
      end,
    },
  },

  config = function()
    local actions = require('fzf-lua.actions')

    require('fzf-lua').setup({
      winopts = {
        preview = {
          default = 'bat',
        },
      },
      files = {
        fd_opts = '--color=never --type f --hidden --follow --exclude .git --exclude vendor',
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --glob '!**/.git/*' --glob '!vendor/*'",
      },
      keymap = {
        builtin = {
          ['<C-q>'] = actions.file_sel_to_qf,
        },
      },
    })
  end,
}
