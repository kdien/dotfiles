return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',

    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter').install({
        'bash',
        'c_sharp',
        'cmake',
        'comment',
        'css',
        'diff',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'graphql',
        'hcl',
        'html',
        'java',
        'javascript',
        'jq',
        'json',
        'lua',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'proto',
        'python',
        'regex',
        'ruby',
        'scss',
        'sql',
        'terraform',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function(arg)
          local excluded = {
            'yaml',
          }
          for _, t in ipairs(excluded) do
            if arg.match ~= t then
              pcall(vim.treesitter.start)
            end
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
      require('treesitter-context').setup({})
      vim.keymap.set('n', '[f', function()
        require('treesitter-context').go_to_context()
      end)
    end,
  },
}
