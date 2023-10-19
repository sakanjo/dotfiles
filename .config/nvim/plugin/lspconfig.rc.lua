local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

local mason_status, mason = pcall(require, "mason")
if mason_status then
  mason.setup()
  local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
  if status2 then
    mason_lspconfig.setup { automatic_installation = true }
  end
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local on_attach = function(client, _)
  local opts = { noremap = true, silent = true }

  if (client.name == 'tsserver') then
    local ts_utils_status, ts_utils = pcall(require, "nvim-lsp-ts-utils")
    if ts_utils_status then
      ts_utils.setup {}
      ts_utils.setup_client(client)
    end
  end

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', "<cmd>Lspsaga goto_definition<CR>", opts)
  vim.keymap.set('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
  vim.keymap.set('n', 'K', "<cmd>Lspsaga hover_doc<CR>", opts)
  vim.keymap.set('n', '<leader>ff', FormatFile, opts)
  vim.keymap.set('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
  vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
end

local servers = { 'intelephense', 'cmake', 'dartls', 'csharp_ls', 'solargraph', 'rust_analyzer',
  'tsserver', 'bashls', 'gopls', 'volar', 'texlab', 'tailwindcss' }

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function() return vim.loop.cwd() end
  }
end

lspconfig.jdtls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ["$/progress"] = vim.schedule_wrap(
      function(_, result)
        if result.message == nil then
          return
        end

        local command = vim.api.nvim_command
        command 'echohl ModeMsg'
        command(string.format('echo "%s"', result.message))
        command 'echohl None'
      end
    ),
  },
})

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
  capabilities = capabilities
}

lspconfig.lua_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    }
  }
}

local clangd_capabilities = require('cmp_nvim_lsp').default_capabilities()
clangd_capabilities.offsetEncoding = { "utf-16" }

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = clangd_capabilities,
  root_dir = function() return vim.loop.cwd() end
}

for _, type in pairs({ 'Error', 'Warn', 'Hint', 'Info' }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = '', texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    format = function(diag)
      return diag.message .. ' '
    end
  },
  update_in_insert = true
})

vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, { silent = true, desc = 'Go to next diagnostic' })
vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, { silent = true, desc = 'Go to prev diagnostic' })
