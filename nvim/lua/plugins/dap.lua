return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },

    keys = {
      { '<F5>', "<Cmd>lua require('dap').continue()<CR>" },
      { '<F10>', "<Cmd>lua require('dap').step_over()<CR>" },
      { '<F11>', "<Cmd>lua require('dap').step_into()<CR>" },
      { '<F12>', "<Cmd>lua require('dap').step_out()<CR>" },
      { '<Leader>b', "<Cmd>lua require('dap').toggle_breakpoint()<CR>" },
      { '<Leader>B', "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
      { '<Leader>lp', "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
      { '<Leader>dr', "<Cmd>lua require('dap').repl.open()<CR>" },
      { '<Leader>dl', "<Cmd>lua require('dap').run_last()<CR>" },
    },

    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      vim.api.nvim_create_user_command('DapListBreakpoints', function()
        dap.list_breakpoints()
        vim.cmd('copen')
      end, {})

      vim.api.nvim_create_user_command('DapClearBreakpoints', function()
        dap.clear_breakpoints()
      end, {})

      require('nvim-dap-virtual-text').setup({ enable_commands = true })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('DapUI', { clear = true }),
        pattern = 'dapui_*',
        command = 'setlocal winborder=none',
      })
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },

    config = function()
      require('mason-nvim-dap').setup({
        ensure_installed = {
          'delve',
          'python',
        },
      })
    end,
  },

  {
    'leoluz/nvim-dap-go',
    dependencies = 'mfussenegger/nvim-dap',
    ft = 'go',
    config = function()
      require('dap-go').setup()
      vim.keymap.set('n', '<leader>dt', "<Cmd>lua require('dap-go').debug_test()<CR>")
    end,
  },

  {
    'mfussenegger/nvim-dap-python',
    dependencies = 'mfussenegger/nvim-dap',
    ft = 'python',
    config = function()
      require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
    end,
  },
}
