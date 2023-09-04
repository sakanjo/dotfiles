local status, todo = pcall(require, "todo-comments")
if (not status) then return end

vim.keymap.set('n', '<leader>tt', ':TodoTelescope<CR>', { silent = true })

todo.setup {
  search = {
    command = "rg",
  }
}
