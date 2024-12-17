return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',

    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,

    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or 'all'
        ensure_installed = {
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
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        modules = {},
        ignore_install = {},

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
      vim.keymap.set('n', '[f', function()
        require('treesitter-context').go_to_context()
      end)
    end,
  },
}
