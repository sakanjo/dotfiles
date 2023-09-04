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

local print = s("prf", {
  t 'println!("',
  d(2, function(args)
    local nodes = {}
    local res = string.gmatch(args[1][1], "([^,]+)%s*")

    for k, _ in res do
      k = k:gsub("%s+", "")
      if k ~= '' then
        table.insert(nodes, t { (k .. ": {}\\n") })
      end
    end

    if #nodes ~= 0 then
      nodes[#nodes].static_text[1] = nodes[#nodes].static_text[1]:sub(0, -3)
    end

    return sn(nil, nodes)
  end, { 1 }),
  t '", ', i(1), t ');'
})
table.insert(snippets, print)

return snippets, autosnippets
