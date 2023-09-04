local status2, ts_config = pcall(require, "nvim-treesitter.configs")
if (not status2) then return end

ts_config.setup {
  endwise = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { 'NvimTree' },
    additional_vim_regex_highlighting = true,
  },
  ensure_installed = {
    "go",
    "java",
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "json5",
    "yaml",
    "css",
    "html",
    "lua",
    'bash',
    'c',
    'make',
    'cmake',
    'cpp',
    'dart',
    'dockerfile',
    'python',
    'scss',
    'vim',
    'ruby',
    'typescript',
    'javascript',
    'query',
    'vue',
    'rust',
    'svelte',
    'markdown',
    'markdown_inline'
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
      },
      include_surrounding_whitespace = false,
    },
    swap = {
      enable = true,
      swap_previous = {
        ["<C-M-h>"] = "@function.outer"
      },
      swap_next = {
        ["<C-M-l>"] = "@function.outer",
      },
    },
    move = {
      enable = true,
      goto_previous_start = {
        ["<C-h>"] = "@function.outer",
      },
      goto_next_start = {
        ["<C-l>"] = "@function.outer",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ["<leader>pf"] = "@function.outer",
        ["<leader>pc"] = "@class.outer"
      },
    },
  },
  matchup = {
    enable = true
  }
}
