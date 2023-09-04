--- Executes keymap then enters insert mode
---@param _keymap string
---@param _remap boolean?
function _NI(_keymap, _remap)
  vim.cmd('silent! exe "norm' .. (_remap and '' or '!') .. ' ' .. _keymap .. '\\<Space>\\<BS>\\<Esc>" | star!')
end

--- Executes keymap
---@param _keymap string
---@param _remap boolean?
function _N(_keymap, _remap)
  vim.cmd('silent! exe "norm' .. (_remap and '' or '!') .. ' ' .. _keymap .. '"')
end

--- Executes keymap
---@param _keymap string
---@param _remap boolean?
---@return function
function N(_keymap, _remap)
  return function()
    return _N(_keymap, _remap)
  end
end

--- Executes keymap then enters insert mode
---@param _keymap string
---@param _remap boolean?
---@return function
function NI(_keymap, _remap)
  return function()
    return _NI(_keymap, _remap)
  end
end

local init_augroup = vim.api.nvim_create_augroup("_Init", {})
vim.api.nvim_create_autocmd('BufNewFile', {
  group = init_augroup,
  pattern = { "*.java", "*.py", "*.go", "*.rb", "*.c", "*.cpp", "*.lua", "*.php", "*.sh", "*.vue", "*.html", "*.tsx", "*.s" },
  callback = function()
    vim.fn.feedkeys('iin')
    vim.api.nvim_feedkeys(vim.api.nvim_eval('"\\<Tab>"'), 'm', true)
  end
})

--- string?
ToggleTerm_Filename = nil

local function RunOnSave(opts)
  if vim.fn.exists('#_Run_on_save') == 1 then
    vim.api.nvim_del_augroup_by_name('_Run_on_save')
    if opts.args == '' then return end
  end

  --- table
  local pattern = nil

  if opts.args ~= '' then
    if opts.args == '%' then
      ToggleTerm_Filename = vim.fn.expand('%')
    elseif opts.args == '*' then
      ToggleTerm_Filename = vim.fn.expand('%')
      pattern = { "*" }
    else
      Toggleterm_Fname = opts.args
    end
  elseif ToggleTerm_Filename ~= nil then
    ToggleTerm_Filename = nil
  end

  pattern = pattern or
      ((ToggleTerm_Filename) and { ToggleTerm_Filename }) or
      { "*.py", "*.rb", "*.sh", "*.go", "*.c", "*.cpp", "*.h", "*.hpp", "*.js", "*.ts", "*.php", "*.lua", "*.rs", "*.s" }

  local run_on_save = vim.api.nvim_create_augroup("_Run_on_save", {})
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = run_on_save,
    pattern = pattern,
    callback = function()
      vim.cmd('exe "norm \\<A-t>"')
    end
  })
end

vim.api.nvim_create_user_command('Tros', RunOnSave, { nargs = '?' })
vim.api.nvim_create_user_command('Pwd', function()
  print(vim.fn.expand('%'))
end, { nargs = 0 })

--- boolean
Format_File = true

vim.api.nvim_create_user_command('Tff', function(opts)
  if opts.args == '' then
    Format_File = not Format_File
  else
    Format_File = opts.args == 'true'
  end
end, { nargs = '?' })

function FormatFile()
  if Format_File then
    vim.lsp.buf.format({
      timeout_ms = 10000,
      filter = function(cl)
        return cl.name == 'null-ls'
      end
    })
  end
end

vim.cmd [[
augroup highlight_follows_focus
  autocmd!
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup highligh_follows_vim
  autocmd!
  autocmd FocusGained * setlocal cursorline
  autocmd FocusLost * setlocal nocursorline
augroup END
]]

vim.cmd [[au FileType go setlocal noexpandtab]]
vim.cmd [[au FileType sh setlocal noexpandtab]]
vim.cmd [[au FileType php setlocal iskeyword+=$]]
vim.cmd [[au FileType vue setlocal iskeyword+=-]]

vim.cmd [[au FileType * set formatoptions-=cro]]

vim.cmd [[hi def link htmlLink None]]
vim.cmd [[au Colorscheme * hi Underlined None]]
