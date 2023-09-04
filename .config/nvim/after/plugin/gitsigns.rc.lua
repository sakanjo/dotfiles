local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

local function on_attach(bufnr)
  local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
  end

  -- Navigation
  map('n', '<M-l>', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
  map('n', '<M-h>', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

  -- Actions
  map('n', '<leader>sl', ':Gitsigns select_hunk<CR>')
  map('n', '<leader>sh', ':Gitsigns stage_hunk<CR>')
  map('v', '<leader>sh', ':Gitsigns stage_hunk<CR>')
  map('n', '<leader>rh', ':Gitsigns reset_hunk<CR>')
  map('v', '<leader>rh', ':Gitsigns reset_hunk<CR>')
  map('n', '<leader>sb', '<cmd>Gitsigns stage_buffer<CR>')
  map('n', '<leader>us', '<cmd>Gitsigns undo_stage_hunk<CR>')
  map('n', '<leader>rb', '<cmd>Gitsigns reset_buffer<CR>')
  map('n', '<leader>ph', '<cmd>Gitsigns preview_hunk<CR>')
  map('n', '<leader>bl', '<cmd>Gitsigns blame_line<CR>')
  map('n', '<leader>bfl', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  map('n', '<leader>tl', '<cmd>Gitsigns toggle_current_line_blame<CR>')
  map('n', '<leader>dt', '<cmd>Gitsigns diffthis<CR>')
  map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

  -- Text object
  map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

gitsigns.setup {
  current_line_blame = false,
  numhl = true,
  current_line_blame_opts = {
    delay = 0,
    ignore_whitespace = true
  },
  current_line_blame_formatter = ' @<author>, <author_time:%Y-%m-%d> - <summary>',
  on_attach = on_attach
}
