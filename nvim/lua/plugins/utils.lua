local event = { 'BufReadPre', 'BufNewFile' }

return {
  {
    'tpope/vim-fugitive',
    event = event
  },

  {
    'tpope/vim-rhubarb',
    event = event
  },

  {
    'tpope/vim-surround',
    event = event
  },

  {
    'numToStr/Comment.nvim',
    event = event,
    config = function()
      require('Comment').setup()
    end
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
    end
  },

  {
    'github/copilot.vim',
    event = event
  }
}
