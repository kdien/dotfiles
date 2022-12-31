local dap = require('dap')
local dapui = require('dapui')

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = 'Debug (Attach) - Remote',
    hostName = '127.0.0.1',
    port = 30303,
  },
}

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

require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<F5>', "<Cmd>lua require('dap').continue()<CR>")
vim.keymap.set('n', '<F10>', "<Cmd>lua require('dap').step_over()<CR>")
vim.keymap.set('n', '<F11>', "<Cmd>lua require('dap').step_into()<CR>")
vim.keymap.set('n', '<F12>', "<Cmd>lua require('dap').step_out()<CR>")
vim.keymap.set('n', '<Leader>b', "<Cmd>lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set('n', '<Leader>B', "<Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set('n', '<Leader>lp', "<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set('n', '<Leader>dr', "<Cmd>lua require('dap').repl.open()<CR>")
vim.keymap.set('n', '<Leader>dl', "<Cmd>lua require('dap').run_last()<CR>")

