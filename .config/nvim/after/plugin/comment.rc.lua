local status, comment = pcall(require, 'Comment')
if (not status) then return end

comment.setup()

vim.keymap.set('n', '<C-_>', 'gcc', { silent = true, remap = true })
vim.keymap.set('v', '<C-_>', 'gbgv', { silent = true, remap = true })
vim.keymap.set('n', '<C-/>', 'gcc', { silent = true, remap = true })
vim.keymap.set('v', '<C-/>', 'gbgv', { silent = true, remap = true })
