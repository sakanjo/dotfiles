local status, cmp = pcall(require, "cmp")
if (not status) then return end

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local luasnip = require('luasnip')

cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        calc = "[Math]",
        buffer = "[Buf]",
        nvim_lsp = "[LSP]"
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },
  mapping = {
    ['<C-space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' }
  }),
  experimental = {
    ghost_text = false
  }
}

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'buffer' }
  })
})

vim.cmd [[set completeopt=menuone,noinsert,noselect]]
