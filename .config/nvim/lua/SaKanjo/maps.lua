vim.g.mapleader = '\\'

local keymap = vim.keymap.set

keymap('n', 'zw', 'ySat<', { silent = true, remap = true })
keymap('n', '<leader>zw', '%V%St', { silent = true, remap = true })

keymap('i', '<C-S-CR>', NI('\\<Esc>O'), { silent = true })
keymap('i', '<C-CR>', NI('\\<Esc>o'), { silent = true })

keymap('i', '<A-j>', '<Esc>bi', { silent = true })
keymap('i', '<A-k>', '<Esc>ea', { silent = true })

keymap('i', '<A-h>', '<left>', { silent = true })
keymap('i', '<A-l>', '<right>', { silent = true })

keymap('n', '<C-S-k>', '"_dd', { silent = true })

keymap('o', 'aa', '<Plug>SidewaysArgumentTextobjA', { silent = true })
keymap('x', 'aa', '<Plug>SidewaysArgumentTextobjA', { silent = true })
keymap('o', 'ia', '<Plug>SidewaysArgumentTextobjI', { silent = true })
keymap('x', 'ia', '<Plug>SidewaysArgumentTextobjI', { silent = true })

keymap('n', '<leader>si', '<Plug>SidewaysArgumentInsertBefore', { silent = true })
keymap('n', '<leader>sa', '<Plug>SidewaysArgumentAppendAfter', { silent = true })
keymap('n', '<leader>sI', '<Plug>SidewaysArgumentInsertFirst', { silent = true })
keymap('n', '<leader>sA', '<Plug>SidewaysArgumentAppendLast', { silent = true })

keymap('n', '<S-h>', ':SidewaysJumpLeft<CR>', { silent = true })
keymap('n', '<S-l>', ':SidewaysJumpRight<CR>', { silent = true })
keymap('n', '<S-M-h>', ':SidewaysLeft<CR>', { silent = true })
keymap('n', '<S-M-l>', ':SidewaysRight<CR>', { silent = true })

keymap('n', '<C-M-j>', ':BufferLineMovePrev<CR>', { silent = true, desc = 'Move tab to prev' })
keymap('n', '<C-M-k>', ':BufferLineMoveNext<CR>', { silent = true, desc = 'Move tab to next' })

---@param char string
---@return function
local function AppendScAnd(char)
  return function()
    _NI('\\<Esc>' .. (vim.fn.getline('.'):sub(-1) == ';' and char or 'A;\\<Esc>' .. char))
  end
end

keymap('i', '<C-j>', AppendScAnd('o'), { silent = true, desc = 'Append ; to the end and do o' })
keymap('i', '<C-M-j>', AppendScAnd('O'), { silent = true, desc = 'Append ; to the end and do O' })
keymap('i', '<C-k>', function()
  if vim.fn.getline('.'):sub(-1) ~= ';' then
    _N('mdA;\\<Esc>`da')
  end
end, { silent = true, desc = 'Append ; to the end and go back' })

-- Not working
-- keymap('n', 'u', N("u`'"), { silent = true, desc = 'Undo without changing cursor position' })

keymap('n', '<C-w>t', ':tabe<cr>', { silent = true, desc = 'Opens new tab' })
keymap('n', '<C-w>z', N('\\<c-w>_\\<c-w>|'), { silent = true, desc = 'Max zoom current split' })

keymap('v', '<leader>sr', ':SnipRun<cr>', { silent = true, desc = 'SnipRun the selected lines' })
keymap('n', 'zr', N('md:%SnipRun\\<cr>`d'), { silent = true, desc = 'SnipRun the whole file' })

keymap('n', '<C-j>', ':BufferLineCyclePrev<cr>', { silent = true, desc = 'Go to prev buffer' })
keymap('n', '<C-k>', ':BufferLineCycleNext<cr>', { silent = true, desc = 'Go to next buffer' })

keymap('n', '<leader>db', N('V0f{%d'), { silent = true, desc = 'Delete block' })
keymap('n', '<leader>cb', NI('V0f{%c'), { silent = true, desc = 'Change block' })
keymap('n', '<leader>yb', N('mdV0f{%y`d'), { silent = true, desc = 'Yank block' })
keymap('n', '<leader>tb', N('mdV0f{%gb`d', true), { silent = true, desc = 'Comment block' })

--- Go to line and do keymap
---@param map string
---@param insert boolean?
---@return function
local function GoAnd(map, insert)
  return function()
    local cmd = vim.v.count == 0 and map or vim.v.count .. 'gg' .. map
    if insert == nil then _NI(cmd) else _N(cmd) end
  end
end

keymap('n', "A", GoAnd('A'), { silent = true, desc = 'Begin a new line above the cursor and insert text' })
keymap('n', "<A-o>", GoAnd('o\\<Esc>ko'), { silent = true, desc = 'Begin a new line above the cursor and insert text' })
keymap('n', "o", GoAnd('o'), { silent = true, desc = 'Begin a new line below the cursor and insert text' })
keymap('n', "O", GoAnd('O'), { silent = true, desc = 'Begin a new line above the cursor and insert text' })
keymap('n', "<CR>", function()
  local cmd = 'O\\<Esc>o'
  if vim.v.count == 0 then
    if string.match(vim.fn.getline('.'), "^%s*$") ~= nil then
    elseif string.match(vim.fn.getline(vim.fn.line('.') + 1), "^%s*$") ~= nil then
      cmd = 'j' .. cmd
    else
      cmd = 'o\\<Esc>' .. cmd
    end
  else
    if string.match(vim.fn.getline(vim.v.count), "^%s*$") ~= nil then
      cmd = 'gg' .. cmd
    elseif string.match(vim.fn.getline(vim.v.count + 1), "^%s*$") ~= nil then
      cmd = 'ggj' .. cmd
    else
      cmd = 'ggo\\<Esc>' .. cmd
    end
    cmd = vim.v.count .. cmd
  end
  _NI(cmd)
end, { silent = true, desc = 'Begin an three new lines below the cursor' })

-- Make . work with visually selected lines
keymap('v', '.', ':norm.<cr>', { silent = true, desc = 'Repeat last change' })

-- Repeat macro over all selected lines
keymap('v', '@', ':norm@', { silent = true, desc = 'Execute the contents of register' })

-- Delete errors
local function contains(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local function delete_errors(severity)
  return function()
    local diagnostics = vim.diagnostic.get(0, { severity = severity })
    local last_line
    local lines = {}
    local i = 0
    local _cmd = ''
    _N('mr')
    for _, v in pairs(diagnostics) do
      local cur = v.lnum + 1
      if not contains(lines, cur) then
        _cmd = _cmd .. (last_line ~= nil and last_line < cur and cur - i or cur) .. 'ggdd'
        last_line = cur
        table.insert(lines, last_line)
        i = i + 1
      end
    end
    _N(_cmd .. '`r')
  end
end

keymap('n', '<leader>de', delete_errors(vim.diagnostic.severity.ERROR),
  { silent = true, desc = 'Delete all error lines' })
keymap('n', '<leader>dh', delete_errors(vim.diagnostic.severity.HINT),
  { silent = true, desc = 'Delete all hint lines' })
keymap('n', '<leader>dw', delete_errors(vim.diagnostic.severity.WARN),
  { silent = true, desc = 'Delete all warning lines' })

keymap('n', '<C-c>', '<Esc>', { silent = true, remap = true, desc = 'Remap to <Esc>' })
keymap('i', '<C-c>', '<Esc>', { silent = true, remap = true, desc = 'Remap to <Esc>' })

-- File utils
keymap('n', '<leader>f<del>', ':silent! Delete!<CR>', { silent = true, desc = 'Delete current file' })
keymap('n', '<leader>fd', ':call feedkeys(":Duplicate " . expand("%:t"))<CR>',
  { silent = true, desc = 'Duplicate current file' })
keymap('n', '<leader>fr', ':call feedkeys(":Move " . expand("%:@"))<CR>', { silent = true, desc = 'Rename current file' })

-- Dont't select last char which is \n
keymap('v', '$', 'g_', { silent = true, desc = 'Go to the end of the line' })

-- Don't store jumps of '{}'
keymap('n', '}', ':<C-u>exe "keepjumps norm! " . v:count1 . "}"<CR>', { silent = true, desc = 'Paragraph backward' })
keymap('n', '{', ':<C-u>exe "keepjumps norm! " . v:count1 . "{"<CR>', { silent = true, desc = 'Paragraph forward' })

-- Increment, Decrement
keymap('n', '+', '<C-a>',
  { silent = true, desc = 'Add [count] to the number or alphabetic character at or after the cursor' })
keymap('n', '-', '<C-x>',
  { silent = true, desc = 'Subtract [count] from the number or alphabetic character at or after the cursor' })

local function GoToImportArea()
  vim.cmd(':keepj norm! gg')
  if string.match(vim.fn.getline('.'), "^%s*$") ~= nil then
    return vim.cmd('exe "norm! S" | star')
  end
  vim.cmd(':keepj norm! }')
  if string.match(vim.fn.getline(vim.fn.line('.') + 1), "^%s*$") ~= nil then
    _NI('S')
  else
    _NI('O')
  end
end

local function GoToBeginning()
  vim.cmd(':keepj norm! gg')
  if string.match(vim.fn.getline('.'), "^%s*$") ~= nil then
    _NI('S')
  else
    vim.cmd('exe "keepj norm! O\\<Esc>O" | star')
  end
end

keymap('n', '<C-a>', GoToImportArea, { silent = true, desc = 'Go to import region and then insert' })
keymap('n', '<A-a>', GoToBeginning, { silent = true, desc = 'Go to first line and then insert' })

keymap('n', '<leader>ay', ":%y<CR>", { silent = true, desc = 'Select everything in the current file' })
keymap('n', '<leader>a', N('ggVG'), { silent = true, desc = 'Select everything in the current file' })

keymap('n', ',', GoAnd('^vg_', false), { silent = true, desc = 'Select current line without leading spaces' })

keymap('n', '<M-w>', 'ysiw)i', { silent = true, remap = true, desc = 'Wrap word under cursor with ()' })
keymap('v', '<M-w>', 'S)i', { silent = true, remap = true, desc = 'Wrap word under cursor with ()' })

-- Vim-Easymotion
keymap('n', '<leader>w', '<Plug>(easymotion-overwin-f)', { silent = true, desc = 'Search character' })

keymap('n', '<leader>(', '<Plug>Dsurround("<Esc>hvbd',
  { silent = true, noremap = false, desc = 'Delete surrounding and do insert' })

keymap('n', 'gp', '`[v`]', { silent = true, desc = 'Reselect pasted text' })

keymap('n', '<S-del>', '"_dd', { silent = true, desc = 'Remap to "_dd' })
keymap('n', '<A-d>', '"_dd', { silent = true, desc = 'Remap to "_dd' })

keymap('n', '<leader><C-k>', ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-k>",
  { silent = true, desc = 'Clear hlsearch' })

keymap('n', '<C-S-j>', 'i<Esc>"ryy"rp`^j', { silent = true, desc = 'Duplicate current line' })
keymap('n', '<C-S-k>', 'i<Esc>"ryy"rp`^', { silent = true, desc = 'Duplicate current line' })
keymap('v', '<C-S-j>', '"ry`<k"rpgv', { silent = true, desc = 'Duplicate current line' })
keymap('v', '<C-S-k>', '"ry`>"rpgv', { silent = true, desc = 'Duplicate current line' })

keymap('n', '<M-k>', ':silent! m-2<CR>==', { silent = true, desc = 'Move current line' })
keymap('n', '<M-j>', ':silent! m+1<CR>==', { silent = true, desc = 'Move current line' })
keymap('v', '<M-k>', ':<home>silent!<end>m\'<-2<CR>gv=gv', { silent = true, desc = 'Move current line' })
keymap('v', '<M-j>', ':<home>silent!<end>m\'>+1<CR>gv=gv', { silent = true, desc = 'Move current line' })

keymap('n', '<M-c>', 'ciw', { silent = true, desc = 'ciw' })

keymap('n', '<C-s>', ':w<CR>', { silent = true, desc = 'Save current file' })

keymap('n', '<C-x>', ':bd!<cr>', { silent = true, desc = 'Closes the current buffer' })
keymap('n', '<leader><C-x>', ':qa!<cr>', { silent = true, desc = 'Closes the current window' })

keymap('v', '<', '<gv', { silent = true, desc = 'Indent and reselect' })
keymap('v', '>', '>gv', { silent = true, desc = 'Indent and reselect' })

keymap('n', '<A-e>', N('i\\<CR>\\<Esc>'), { silent = true, desc = 'Break line' })
keymap('n', '<A-u>', N('Jx'), { silent = true, desc = 'Join line without a space' })

-- Delete chunks

keymap('n', 'd]', 'V}"_d', { silent = true, desc = 'Delete until next space' })
keymap('n', 'd[', 'V{"_d', { silent = true, desc = 'Delete until prev space' })

-- Paste replace visual selection without copying it
keymap('v', 'p', '"_c<C-r><C-o>+<Esc>', { silent = true, desc = 'Paste content' })

keymap('n', 'q:', ':q<CR>', { silent = true, desc = 'Disable annoying command line thing' })

-- Execute run-on

keymap('n', '<leader>r', ':silent !/home/e4404/gits/oss/run-on/target/debug/run-on run <CR>',
  { silent = true, desc = 'Execute run-on run' })
keymap('n', '<leader>1', ':silent !/home/e4404/gits/oss/run-on/target/debug/run-on run --id 1 <CR>',
  { silent = true, desc = 'Execute run-on run --id 1' })
keymap('n', '<leader>2', ':silent !/home/e4404/gits/oss/run-on/target/debug/run-on run --id 2 <CR>',
  { silent = true, desc = 'Execute run-on run --id 2' })
keymap('n', '<leader>3', ':silent !/home/e4404/gits/oss/run-on/target/debug/run-on run --id 3 <CR>',
  { silent = true, desc = 'Execute run-on run --id 3' })
keymap('n', '<leader>4', ':silent !/home/e4404/gits/oss/run-on/target/debug/run-on run --id 4 <CR>',
  { silent = true, desc = 'Execute run-on run --id 4' })

-- Maintain the cursor position when yanking a visual selection
keymap('v', 'y', "'my\"' .. v:register .. 'y`y'",
  { silent = true, expr = true, desc = 'Yank {motion} text [into register x]' })
keymap('v', 'Y', "'my\"' .. v:register .. 'y`y'",
  { silent = true, expr = true, desc = 'Yank {motion} text [into register x]' })

keymap('x', 'ga', '<Plug>(EasyAlign)', { silent = true, desc = 'Text alignment' })
keymap('n', 'ga', '<Plug>(EasyAlign)', { silent = true, desc = 'Text alignment' })

keymap('s', 'p', 'p')
keymap('s', 'y', 'y')
keymap('s', '.', '.')
keymap('s', '<BS>', 'i<BS>')

-- Disable arrows
keymap('n', '<up>', '<nop>')
keymap('n', '<down>', '<nop>')
keymap('v', '<up>', '<nop>')
keymap('v', '<down>', '<nop>')
keymap('v', '<left>', '<nop>')
keymap('v', '<right>', '<nop>')
keymap('i', '<up>', '<nop>')
keymap('i', '<down>', '<nop>')
keymap('i', '<left>', '<nop>')
keymap('i', '<right>', '<nop>')
keymap('s', '<right>', '<Esc>gvo<Esc>a', { silent = true })
keymap('s', '<left>', '<Esc>i', { silent = true })
