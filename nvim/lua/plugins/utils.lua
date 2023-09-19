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
  }
}
