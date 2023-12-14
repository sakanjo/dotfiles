local status, toggleterm = pcall(require, "toggleterm")
if (not status) then return end

toggleterm.setup {
  size = function()
    return vim.o.columns / 2.75
  end,
  float_opts = {
    border = 'curved'
  },
  start_in_insert = true,
  shell = vim.o.shell,
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true, silent = true, buffer = 0 }
  vim.keymap.set('t', '<C-t>', [[<C-\><C-n>:100ToggleTerm direction="float"<CR>]], opts)

  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
end

vim.cmd [[autocmd! TermOpen term://* lua set_terminal_keymaps()]]

vim.keymap.set('n', '<C-t>', ':100ToggleTerm direction="float"<CR>', { silent = true, desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader><C-t>', ':ToggleTermToggleAll<CR>', { silent = true, desc = 'Toggle all terminals' })

function RunCMD()
  if vim.v.count ~= 0 then
    return vim.cmd(':' .. vim.v.count .. 'ToggleTerm direction="vertical"')
  end

  local filename = ToggleTerm_Filename or vim.fn.expand("%")
  local ext = (ToggleTerm_Filename and vim.fn.fnamemodify(ToggleTerm_Filename, ':e')) or vim.fn.expand("%:e")

  local function Run(cmd, file)
    toggleterm.exec("c; " .. cmd .. (file and (" " .. filename) or ""), 99, nil, nil, 'vertical')
  end

  if ext == 'py' then
    Run("py", true)
  elseif ext == 'rb' then
    Run("ruby", true)
  elseif ext == 'sh' then
    Run("bash", true)
  elseif ext == 'go' then
    Run("go run .")
  elseif ext == 'c' or ext == 'cpp' or ext == 'h' or ext == 'hpp' then
    Run("make")
  elseif ext == 's' or ext == 'asm' then
    Run("ASM", true)
  elseif ext == 'js' then
    Run("node", true)
  elseif ext == 'ts' then
    Run("ts-node", true)
  elseif ext == 'php' then
    Run("php", true)
  elseif ext == 'lua' then
    Run("lua", true)
  elseif ext == 'dart' then
    Run("dart run", true)
  elseif ext == 'rs' then
    Run("cargo run -q")
  end
end

vim.keymap.set('n', '<M-t>', RunCMD, { silent = true })
