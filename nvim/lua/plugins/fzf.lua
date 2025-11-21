local git_root = function()
  return vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
end

return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,

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
        height = 0.4,
        width = 1,
        row = 1,
        preview = {
          default = 'bat',
          layout = 'horizontal',
          horizontal = 'right:50%',
          vertical = 'down:50%',
          hidden = 'nohidden',
          scrollbar = false,
        },
      },
      fzf_opts = {
        ['--layout'] = 'reverse',
        ['--info'] = 'inline',
        ['--preview-window'] = 'right:50%',
      },
      files = {
        prompt = 'Files> ',
        fd_opts = '--color=never --type f --hidden --follow --exclude .git --exclude vendor',
        actions = {
          ['ctrl-q'] = actions.file_sel_to_qf,
          ['ctrl-t'] = actions.file_tabedit,
          ['ctrl-x'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
        },
      },
      grep = {
        prompt = 'Grep> ',
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden --glob '!**/.git/*' --glob '!vendor/*'",
        actions = {
          ['ctrl-q'] = actions.file_sel_to_qf,
          ['ctrl-t'] = actions.file_tabedit,
          ['ctrl-x'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
        },
      },
      buffers = {
        prompt = 'Buffers> ',
        actions = {
          ['ctrl-q'] = actions.file_sel_to_qf,
          ['ctrl-t'] = actions.file_tabedit,
          ['ctrl-x'] = actions.file_split,
          ['ctrl-v'] = actions.file_vsplit,
          ['ctrl-d'] = { fn = actions.buf_del, reload = true },
        },
      },
      helptags = {
        prompt = 'Help> ',
        previewer = { _ctor = false },
      },
      keymaps = {
        prompt = 'Keymaps> ',
        previewer = { _ctor = false },
      },
      keymap = {
        fzf = {
          ['ctrl-/'] = 'toggle-preview',
        },
      },
    })

    -- Register fzf-lua as the UI interface for vim.ui.select
    require('fzf-lua').register_ui_select()
  end,
}
