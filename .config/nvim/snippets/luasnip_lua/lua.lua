local ls = require('luasnip')

local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

local snippets, autosnippets = {}, {}

local print = s('pr',
  fmt("print({})", { i(1) })
)
table.insert(snippets, print)

return snippets, autosnippets
