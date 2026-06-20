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
    'kdien/yaml-companion.nvim',
    branch = 'main',
    ft = 'yaml',

    config = function()
      require('yaml-companion').setup({
        schemas = {
          {
            name = 'Argo',
            uri = 'https://raw.githubusercontent.com/argoproj/argo-workflows/main/api/jsonschema/schema.json',
          },
        },
      })

      vim.keymap.set('n', '<leader>sy', function()
        require('yaml-companion').open_ui_select()
      end)

      local ok, _ = pcall(require, 'telescope', 'load_extension("yaml_schema")')
      if ok then
        vim.keymap.set('n', '<leader>sy', '<Cmd>Telescope yaml_schema<CR>')
      end
    end,
  },
}
