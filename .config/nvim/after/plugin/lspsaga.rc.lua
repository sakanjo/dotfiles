vim.opt.termguicolors = true
local status, lspsaga = pcall(require, 'lspsaga')
if (not status) then return end

lspsaga.setup({
  lightbulb = {
    enable = false
  },
  code_action = {
    keys = {
      quit = '<C-c>',
    },
  },
  ui = {
    border = "rounded",
  }
})
