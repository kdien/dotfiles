return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text'
    },

    keys = {
      { '<F5>',       "<Cmd>lua require('dap').continue()<CR>" },
      { '<F10>',      "<Cmd>lua require('dap').step_over()<CR>" },
      { '<F11>',      "<Cmd>lua require('dap').step_into()<CR>" },
      { '<F12>',      "<Cmd>lua require('dap').step_out()<CR>" },
      { '<Leader>b',  "<Cmd>lua require('dap').toggle_breakpoint()<CR>" },
      { '<Leader>B',  "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
      { '<Leader>lp', "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
      { '<Leader>dr', "<Cmd>lua require('dap').repl.open()<CR>" },
      { '<Leader>dl', "<Cmd>lua require('dap').run_last()<CR>" }
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

      require('nvim-dap-virtual-text').setup({})
    end
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap'
    },

    config = function()
      require('mason-nvim-dap').setup({
        ensure_installed = {
          'delve',
        }
      })
    end
  },

  {
    'leoluz/nvim-dap-go',
    dependencies = 'mfussenegger/nvim-dap',
    ft = 'go',
    config = function()
      require('dap-go').setup()
    end
  }
}
