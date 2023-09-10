if not vim.fn.exists('g:loadedCutlass') then
  return
end

vim.keymap.set('n', 'd', 'd', { noremap = true })
vim.keymap.set('n', 'dd', 'dd', { noremap = true })
