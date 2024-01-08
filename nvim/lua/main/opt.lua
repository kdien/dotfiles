vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

vim.opt.signcolumn = 'auto:2'

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.mouse = 'a'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10

vim.opt.laststatus = 3

function ParseGitBranch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if string.len(branch) > 0 then
    branch = '[' .. branch .. ']'
  end
  return branch
end

vim.opt.statusline = "%{luaeval('ParseGitBranch()')}%=%-F %m%r%w%=%y [%{&fileformat}]  %l:%c  %p%%"

vim.g.netrw_banner = 0
