return {
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',

    build = function()
      vim.fn['mkdp#util#install']()
    end
  },

  {
    'pearofducks/ansible-vim',
    ft = 'ansible',
    keys = {
      { '<leader>ab',
        function()
          vim.lsp.stop_client(vim.lsp.get_active_clients({ name = 'yamlls' }))
          vim.opt.filetype = 'ansible'
          vim.opt.syntax = 'yaml.ansible'
        end
      }
    }
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java'
  }
}
