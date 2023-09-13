vim.g.textobj_between_no_default_key_mappings = true

vim.keymap.set('o', 'aQ', '<Plug>(textobj-between-a)')
vim.keymap.set('x', 'aQ', '<Plug>(textobj-between-a)')
vim.keymap.set('o', 'iQ', '<Plug>(textobj-between-i)')
vim.keymap.set('x', 'iQ', '<Plug>(textobj-between-i)')
