local status, ts_node = pcall(require, 'ts-node-action')
if (not status) then return end

ts_node.setup({})

vim.keymap.set("n", "<A-q>", ts_node.node_action, { silent = true, desc = "Trigger Node Action" })
