local use_lualine = true

if use_lualine then
  require('lualine').setup {
    sections = {
      lualine_a = {
        'mode'
      },
      lualine_b = {
        'branch',
        'diff',
        'diagnostics'
      },
      lualine_c = {
        {
          'filename',
          path = 3
        },
      },
      lualine_x = {
        'filetype',
        'fileformat'
      },
      lualine_y = {
        'location'
      },
      lualine_z = {
        'progress'
      }
    },
  }

else
  function ParseGitBranch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
      branch = '[' .. branch .. ']'
    end
    return branch
  end

  vim.opt.statusline = "%{luaeval('ParseGitBranch()')}%=%-F %m%r%w%=%y [%{&fileformat}]  %l:%c  %p%%"
end
