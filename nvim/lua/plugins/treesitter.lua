return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',

    build = ':TSUpdate',

    config = function()
      local langs = {
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
      }

      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function(ev)
          local excluded_ft = {
            'yaml',
          }
          for _, l in ipairs(langs) do
            local filetypes = vim.treesitter.language.get_filetypes(l)
            if vim.tbl_contains(filetypes, ev.match) and not vim.tbl_contains(excluded_ft, ev.match) then
              vim.treesitter.start()
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
