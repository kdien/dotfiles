if vim.env.GHOSTTY_RESOURCES_DIR and vim.env.GHOSTTY_RESOURCES_DIR ~= '' then
  TERM_FG_COLOR = vim.fn.system("ghostty +show-config | awk -F '=' '/^foreground =/ {print $2}' | tr -d [:space:]")
end

if vim.env.ALACRITTY_SOCKET then
  local term_fg = vim.fn.system('alacritty msg get-config 2>/dev/null | jq -r .colors.primary.foreground | tr -d [:space:]')
  if term_fg and term_fg ~= '' then
    TERM_FG_COLOR = term_fg
  end
end

require('main.opt')
require('main.keymaps')
require('main.lazy')
require('main.autocmd')
require('main.user_commands')
require('main.statusline')

-- Disable LSP semantic token highlighting
for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
  vim.api.nvim_set_hl(0, group, {})
end

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
