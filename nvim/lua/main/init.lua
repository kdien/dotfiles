local impatient_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/impatient.nvim'
if vim.fn.empty(vim.fn.glob(impatient_path)) == 0 then
  require('impatient')
end

require('main.opt')
require('main.globals')
require('main.keymaps')
require('main.packer')
require('main.autocmd')
