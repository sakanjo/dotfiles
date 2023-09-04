vim.g.textobj_between_no_default_key_mappings = true

vim.keymap.set('o', 'aq', '<Plug>(textobj-between-a)')
vim.keymap.set('x', 'aq', '<Plug>(textobj-between-a)')
vim.keymap.set('o', 'iq', '<Plug>(textobj-between-i)')
vim.keymap.set('x', 'iq', '<Plug>(textobj-between-i)')
