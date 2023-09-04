local status, trouble = pcall(require, "trouble")
if (not status) then return end

vim.keymap.set('n', '<A-p>', ':Trouble<CR>', { silent = true })

trouble.setup {
  action_keys = {
    open_split = '<C-s>',
  },
  auto_preview = false
}
