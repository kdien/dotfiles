vim.opt.winborder = 'rounded'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = 'eob: '

vim.opt.smartindent = true

vim.opt.signcolumn = 'auto:2'

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.mouse = 'a'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10

vim.opt.laststatus = 2

vim.g.netrw_banner = 0

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }

  vim.g.netrw_browsex_viewer = 'cmd.exe /C start'
end
