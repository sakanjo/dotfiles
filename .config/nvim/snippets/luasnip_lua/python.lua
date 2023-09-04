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

local class = s("cl", {
  t "class ", i(1, "Fclass"), t { ":", "" },
  t "\tdef __init__(self", i(2), t ") -> None:",
  t { "", "" },
  d(3, function(args)
    local nodes = {}

    for k, _ in string.gmatch(args[1][1], "([%w_]+):?%s*%w*") do
      table.insert(nodes, t { ("\t\tself." .. k .. " = " .. k), "" })
    end

    return sn(nil, nodes)
  end, { 2 }),
  t { "", "\t" }, i(4, "pass")
})
table.insert(snippets, class)

return snippets, autosnippets
