if not vim.fn.exists('g:loadedSubversive') then
  return
end

vim.keymap.set('n', '<leader>r', '<Plug>(SubversiveSubstitute)', { silent = true })
vim.keymap.set('n', '<leader>rr', '<plug>(SubversiveSubstituteLine)', { silent = true })
vim.keymap.set('n', '<leader>R', '<plug>(SubversiveSubstituteToEndOfLine)', { silent = true })
