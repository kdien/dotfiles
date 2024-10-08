return {
  {
    'iamcco/markdown-preview.nvim',
    branch = 'master',
    ft = 'markdown',

    build = function()
      vim.fn['mkdp#util#install']()
    end,

    config = function()
      vim.g.mkdp_echo_preview_url = 1
    end,
  },

  {
    'pearofducks/ansible-vim',
    ft = 'ansible',
    keys = {
      {
        '<leader>ab',
        function()
          vim.lsp.stop_client(vim.lsp.get_clients({ name = 'yamlls' }))
          vim.opt.filetype = 'ansible'
          vim.opt.syntax = 'yaml.ansible'
        end,
      },
    },
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },

  {
    'someone-stole-my-name/yaml-companion.nvim',
    branch = 'main',
    event = 'VeryLazy',

    keys = {
      { '<leader>sy', '<Cmd>Telescope yaml_schema<CR>' },
    },

    config = function()
      require('telescope').load_extension('yaml_schema')
    end,
  },
}
