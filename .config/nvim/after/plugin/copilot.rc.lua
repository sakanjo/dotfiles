local status, _ = pcall(require, "_copilot")
if (not status) then return end

vim.g.copilot_no_tab_map = true

vim.cmd [[
  imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
]]
