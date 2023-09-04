local toggleterm = require("toggleterm")
vim.g['test#php#phpunit#executable'] = 'vendor/bin/phpunit'

vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { silent = true })
vim.keymap.set('n', '<Leader>tc', ':TestClass<CR>', { silent = true })
vim.keymap.set('n', '<A-i>', ':TestLast<CR>', { silent = true })

local function EchoStrategy(cmd)
  toggleterm.exec('c; ' .. cmd, 101, nil, nil, 'vertical')
end

vim.g['test#custom_strategies'] = { toggle_term = EchoStrategy }
vim.g['test#strategy'] = 'toggle_term'
