local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local previewers_utils = require('telescope.previewers.utils')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  local maxsize = 250000
  filepath = vim.fn.expand(filepath)

  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > maxsize then
      local cmd = { "head", "-c", maxsize, filepath }
      previewers_utils.job_maker(cmd, bufnr, opts)
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

---@param keymap string
local function cfg(keymap)
  return {
    layout_config = {
      prompt_position = "top",
      width = .75,
      preview_width = .6
    },
    preview = {
      hide_on_startup = false
    },
    mappings = {
      i = {
        [keymap] = actions.close
      }
    }
  }
end

telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    prompt_prefix = ' » ',
    selection_caret = ' » ',
    preview = {
      filesize_limit = 1,
      treesitter = false,
      hide_on_startup = true,
    },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { '.git/', 'vendor/', 'node_modules/', 'nova/' },
    mappings = {
      i = {
        ['<C-s>'] = actions.select_horizontal,
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true,
      layout_config = {
        prompt_position = "top",
        width = .6
      }
    },
    live_grep = cfg('<C-S-f>'),
    lsp_document_symbols = cfg('<C-S-o>'),
    lsp_dynamic_workspace_symbols = cfg('<C-S-A-o>'),
  },
  extensions = {
    fzf = {
      case_mode = 'ignore_case'
    }
  },
}

telescope.load_extension('fzf')

vim.keymap.set('n', '<C-p>', builtin.find_files)
vim.keymap.set('n', '<C-S-f>', builtin.live_grep)
vim.keymap.set('n', '<C-S-o>', builtin.lsp_document_symbols)
vim.keymap.set('n', '<C-S-A-o>', builtin.lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<leader>lg', builtin.live_grep)
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>lw', builtin.lsp_dynamic_workspace_symbols)
