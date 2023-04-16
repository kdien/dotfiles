require('lualine').setup {
  sections = {
    lualine_a = {
      'mode'
    },
    lualine_b = {
      'branch', 'diff', 'diagnostics'
    },
    lualine_c = {
      {
        'filename',
        path = 3
      },
    },
    lualine_x = {
      'filetype',
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF'
        }
      },
      'encoding'
    },
    lualine_y = {
      'progress'
    },
    lualine_z = {
      'location'
    }
  },
}

