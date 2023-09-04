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

local main_template = [[public class {} {{
  public static void main(String[] args) {{
    {}
  }}
}}]]

local subclass_template = [[package {};

public class {} {{
  {}
}}]]

local init = s("in", {
  d(1, function()
    local filename = vim.fn.expand('%:t:r')
    local dir = vim.fn.fnamemodify(vim.fn.expand('%'), ':h')
    if dir == '.' then
      return sn(nil, fmt(main_template, {
        filename, i(1)
      }))
    end

    return sn(nil, fmt(subclass_template, {
      string.gsub(dir, '/', '.'), filename, i(1)
    }))
  end)
})
table.insert(snippets, init)

return snippets, autosnippets
