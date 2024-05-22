return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
      require('conform').setup({
        notify_on_error = true,
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          sh = { 'shfmt' },
          terraform = { 'terraform_fmt' },
          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },
      })

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- :FormatDisable! will disable auto-formatting globally
          vim.g.disable_autoformat = true
        else
          vim.b.disable_autoformat = true
        end
      end, { bang = true })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.g.disable_autoformat = false
        vim.b.disable_autoformat = false
      end, {})
    end,
  },
}
