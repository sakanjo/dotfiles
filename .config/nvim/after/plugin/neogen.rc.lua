local status, neogen = pcall(require, "neogen")
if (not status) then return end

vim.keymap.set('n', '<leader>nf', ':Neogen func<CR>')
vim.keymap.set('n', '<leader>nc', ':Neogen class<CR>')

neogen.setup {
  snippet_engine = 'luasnip'
}
