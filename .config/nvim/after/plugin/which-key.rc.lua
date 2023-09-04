local status, wk = pcall(require, "which-key")
if (not status) then return end

vim.keymap.set('n', '<leader>tw', ':WhichKey<CR>', { silent = true })

wk.setup {
  plugins = {
    marks = false,
    registers = false,
    spelling = {
      enabled = true,
      suggestions = 40
    }
  }
}
