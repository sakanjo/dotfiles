local status, lsp_signature = pcall(require, 'lsp_signature')
if (not status) then return end

lsp_signature.setup({
  toggle_key = '<C-e>',
  hint_enable = false
})
