require('main.opt')
require('main.keymaps')
require('main.lazy')
require('main.autocmd')
require('main.user_commands')
require('main.statusline')

vim.cmd('colorscheme codedark')

-- Load local config
local local_conf = vim.fn.expand('$HOME/.config/nvim.local')
if vim.fn.isdirectory(local_conf) == 1 then
  local files = vim.fn.globpath(local_conf, '*.lua', true, true)
  if type(files) == 'table' then
    for _, file in ipairs(files) do
      local ok, err = pcall(dofile, file)
      if not ok then
        vim.notify('Error loading ' .. file .. ': ' .. err, vim.log.levels.ERROR)
      end
    end
  end
end
