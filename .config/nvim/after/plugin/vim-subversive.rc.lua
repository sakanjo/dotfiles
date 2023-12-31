if not vim.fn.exists('g:loadedSubversive') then
  return
end

vim.keymap.set('n', 'gr', '<Plug>(SubversiveSubstitute)', { silent = true })
vim.keymap.set('n', 'grr', '<plug>(SubversiveSubstituteLine)', { silent = true })
vim.keymap.set('n', 'gR', '<plug>(SubversiveSubstituteToEndOfLine)', { silent = true })

vim.keymap.set('n', '<leader>gr', '<plug>(SubversiveSubstituteRange)', { silent = true })
vim.keymap.set('x', '<leader>gr', '<plug>(SubversiveSubstituteRange)', { silent = true })
vim.keymap.set('n', '<leader>grr', '<plug>(SubversiveSubstituteWordRange)', { silent = true })
