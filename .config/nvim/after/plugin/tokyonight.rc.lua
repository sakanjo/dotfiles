local status, theme = pcall(require, "tokyonight")
if (not status) then return end

theme.setup({
  transparent = true
})

vim.cmd [[colo tokyonight]]

vim.cmd [[hi DiagnosticVirtualTextHint guifg=Cyan guibg=None]]
vim.cmd [[hi DiagnosticVirtualTextError guifg=Red guibg=None]]
