function StatusGitBranch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if string.len(branch) > 0 then
    branch = '[' .. branch .. ']'
  end
  return branch
end

function StatusFileType()
  if vim.bo.filetype == 'yaml' then
    local schema = require('yaml-companion').get_buf_schema(0)
    if schema.result[1].name == 'none' then
      return 'yaml'
    else
      return 'yaml.' .. schema.result[1].name
    end
  else
    return vim.bo.filetype
  end
end

vim.opt.statusline = "%-f %m%r%w%=[%{luaeval('StatusFileType()')}] [%{&fileformat}] %l:%c %p%%"
