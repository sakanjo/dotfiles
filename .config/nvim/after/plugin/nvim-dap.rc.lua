local status, dap = pcall(require, 'dap')
if (not status) then return end

-- dapui --
local dapui = require('dapui')
dapui.setup({
  controls = {
    enabled = false
  },
})

local function close()
  dap.repl.close()
  dapui.close({})
end

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = close
dap.listeners.before.event_exited["dapui_config"] = close

-- dap configrations
for _, _dap in pairs({ 'dap-python', 'dap-go' }) do
  require(_dap).setup()
end

vim.keymap.set('n', '<leader>da', dap.step_over, { silent = true, desc = 'Step over' })
vim.keymap.set('n', '<leader>do', dap.step_out, { silent = true, desc = 'Step out' })
vim.keymap.set('n', '<leader>di', dap.step_into, { silent = true, desc = 'Step into' })

vim.keymap.set('n', '<A-b>', function()
  if vim.v.count == 0 then
    dap.toggle_breakpoint()
  else
    vim.cmd('norm! mp' .. vim.v.count .. 'gg')
    dap.toggle_breakpoint()
    vim.cmd('norm! `p')
  end
end, { silent = true })
vim.keymap.set('n', '<leader>dr', dap.clear_breakpoints, { silent = true, desc = 'Clear all breakpoints' })

vim.keymap.set('n', '<leader>dl', dap.run_last, { silent = true, desc = 'Run last' })
vim.keymap.set('n', '<leader>dt', dap.terminate, { silent = true, desc = 'Terminate' })
vim.keymap.set('n', '<leader>dc', dap.continue, { silent = true, desc = 'Run' })
