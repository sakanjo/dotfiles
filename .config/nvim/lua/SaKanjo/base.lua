vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ''
vim.opt.title = true
vim.opt.shell = 'fish'
vim.opt.expandtab = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.smarttab = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 10
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.opt.syntax = 'on'

-- highlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.netrw_banner = 0

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 1000
vim.opt.fillchars = 'eob: '

vim.opt.undofile = true
vim.cmd [[set undodir=~/.vim/undodir]]

vim.opt.shortmess:append({ I = true })
vim.opt.wildmode = 'longest:full,full'
vim.opt.signcolumn = 'yes:1'
vim.opt.showmode = false
vim.opt.updatetime = 4001
vim.opt.redrawtime = 10000
