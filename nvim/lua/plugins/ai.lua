return {
  {
    'github/copilot.vim',
    cmd = { 'Copilot' },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    cmd = { 'CopilotChat' },

    keys = {
      { '<leader>cc', '<Cmd>CopilotChatToggle<CR>' },
    },

    config = function()
      require('CopilotChat').setup({
        model = os.getenv('GH_COPILOT_MODEL') or 'gpt-4.1',
        temperature = 0.1,
        window = {
          layout = 'vertical',
          width = 0.5,
        },
        auto_insert_mode = false,
        chat_autocomplete = false,
      })
    end,
  },
}
