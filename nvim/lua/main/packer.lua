-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Module caching
  use 'lewis6991/impatient.nvim'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  use 'folke/neodev.nvim'

  -- DAP (Debug Adapter Protocol)
  use 'mfussenegger/nvim-dap'

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
     'mfussenegger/nvim-dap',
    }
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    requires = {
     'mfussenegger/nvim-dap',
    }
  }

  -- Highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Git support
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  use 'numToStr/Comment.nvim'
  use 'tpope/vim-surround'
  use 'nvim-lualine/lualine.nvim'

  -- Colorschemes
  use 'navarasu/onedark.nvim'

  -- Markdown preview
  use {
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end
  }

  -- Code
  use 'pearofducks/ansible-vim' -- Ansible
  use 'mfussenegger/nvim-jdtls' -- Java

  -- Sync all plugins
  if is_bootstrap then
    require('packer').sync()
  end
end)
