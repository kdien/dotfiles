local event = { 'BufReadPre', 'BufNewFile' }

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = event,
    dependencies = 'williamboman/mason.nvim',

    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {
          'buf', -- Protobuf
          'editorconfig-checker',
          'gofumpt',
          'shellcheck',
          'shfmt',
          'stylua',
        },

        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
      })
    end,
  },

  {
    'tpope/vim-fugitive',
    event = event,
  },

  {
    'tpope/vim-rhubarb',
    event = event,
  },

  {
    'tpope/vim-surround',
    event = event,
  },

  {
    'numToStr/Comment.nvim',
    event = event,
    config = function()
      require('Comment').setup()
    end,
  },

  {
    'diepm/vim-rest-console',
    ft = 'rest',

    config = function()
      vim.g.vrc_allow_get_request_body = 1
      vim.g.vrc_auto_format_response_enabled = 1

      local vrc_curl_opts = {}
      vrc_curl_opts['-sSL'] = ''
      vim.g.vrc_curl_opts = vrc_curl_opts

      vim.g.vrc_keepalt = 1
      vim.g.vrc_response_default_content_type = 'application/json'
      vim.g.vrc_set_default_mapping = 0
      vim.keymap.set('n', '<leader>rq', '<Cmd>call VrcQuery()<CR>')
    end,
  },

  {
    'j-hui/fidget.nvim',
    version = '1.x.x',
    event = event,

    opts = {
      progress = {
        display = {
          render_limit = 5,
          done_ttl = 1,
        },
      },
      notification = {
        window = {
          winblend = 0,
          border = 'none',
        },
      },
    },
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set('n', '<leader>e', '<Cmd>Oil<CR>')

      local open_cmd = 'xdg-open'
      if vim.fn.has('wsl') == 1 then
        open_cmd = 'wslview'
      elseif vim.fn.has('mac') == 1 then
        open_cmd = 'open'
      end

      vim.api.nvim_create_user_command('Browse', function(opts)
        vim.fn.system({ open_cmd, opts.fargs[1] })
      end, { nargs = 1 })
    end,
  },

  {
    'github/copilot.vim',
    lazy = true,
    cmd = { 'Copilot' },
  },
}
