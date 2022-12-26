require('nvim-tree').setup({
  open_on_setup = false,
  renderer = {
    indent_markers = {
      enable = true
    }
  },
  filters = {
    dotfiles = false
  }
})

vim.keymap.set({'n', 'v'}, '<leader>tt', vim.cmd.NvimTreeToggle)
