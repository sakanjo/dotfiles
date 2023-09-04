local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

-- TODO: Fix is_registered

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

vim.api.nvim_clear_autocmds({ group = augroup })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = FormatFile
})

null_ls.setup({
  sources = {
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.shfmt,
    formatting.rustfmt,
    formatting.clang_format,
    formatting.gofmt,
    formatting.pint.with({
      condition = function(utils)
        return utils.root_has_file({ './vendor/bin/pint' })
      end
    }),
    formatting.phpcsfixer.with({
      condition = function()
        return not null_ls.is_registered(formatting.pint)
      end
    }),
    formatting.latexindent,
    formatting.eslint_d,
    formatting.prettierd.with({
      condition = function()
        return not null_ls.is_registered(formatting.eslint_d)
      end
    }),
    formatting.ruff,
    diagnostics.shellcheck,
    diagnostics.fish,
    -- diagnostics.markdownlint,
    diagnostics.ruff,
    diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m} #{c}",
      prefer_local = "node_modules/.bin",
      condition = function(utils)
        return utils.root_has_file({
          '.eslintrc', '.eslintrc.js', '.eslintrc.cjs',
          '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json'
        })
      end
    }),
    code_actions.eslint_d,
    code_actions.shellcheck
  },
})

local status2, mason_null_ls = pcall(require, 'mason-null-ls')
if status2 then
  mason_null_ls.setup({ automatic_installation = true })
end
