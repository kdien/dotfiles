return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
}
