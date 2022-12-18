vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.cmd.colorscheme('onedark')
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

vim.opt.mouse = 'a'

vim.opt.splitbelow = true
vim.opt.splitright = true

