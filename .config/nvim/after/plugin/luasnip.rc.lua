local status, ls = pcall(require, "luasnip")
if (not status) then return end

local luasnip_lua
local luasnip_vscode

if vim.fn.has('win32') == 1 then
  luasnip_lua = '\\snippets\\luasnip_lua\\'
  luasnip_vscode = '\\snippets\\luasnip_vscode\\'
else
  luasnip_lua = '/snippets/luasnip_lua'
  luasnip_vscode = '/snippets/luasnip_vscode'
end

require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. luasnip_lua })
require('luasnip.loaders.from_vscode').load({ paths = vim.fn.stdpath('config') .. luasnip_vscode })

ls.config.set_config({
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = false,
  history = true,
  delete_check_events = "TextChanged",
})

local capitalize = function(string)
  return string:sub(1, 1):upper() .. string:sub(2, -1)
end

local function current_basename()
  return capitalize(vim.fn.expand("%:t:s?\\.[^\\.]\\+$??"))
end

ls.env_namespace("CUR", { vars = { BASENAME = current_basename } })

vim.keymap.set('i', '<Tab>', function()
  if ls.expand_or_jumpable() then
    return '<Plug>luasnip-expand-or-jump'
  end
  return '<Tab>'
end, { silent = true, expr = true })
vim.keymap.set('i', '<S-Tab>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)
vim.keymap.set('s', '<Tab>', function()
  if ls.jumpable() then
    return '<Plug>luasnip-jump-next'
  end
  return '<Tab>'
end, { silent = true, expr = true })
vim.keymap.set('s', '<S-Tab>', function()
  if ls.jumpable(-1) then
    return '<Plug>luasnip-jump-prev'
  end
end, { silent = true, expr = true })
