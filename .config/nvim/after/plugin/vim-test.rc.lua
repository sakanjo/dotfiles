local toggleterm = require("toggleterm")

vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>', { silent = true })
vim.keymap.set('n', '<leader>tc', ':TestClass<CR>', { silent = true })
vim.keymap.set('n', '<A-i>', ':TestLast<CR>', { silent = true })

local function EchoStrategy(cmd)
  toggleterm.exec('cls; ' .. cmd, 101, nil, nil, 'vertical')
end

vim.g['test#custom_strategies'] = { toggle_term = EchoStrategy }
vim.g['test#strategy'] = 'toggle_term'
vim.g['test#php#phpunit#executable'] = 'vendor/bin/phpunit'
