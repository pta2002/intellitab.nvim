local v = vim.api

local treesitter = require("nvim-treesitter")

local function get_line_indent(line, sw)
  local indent = 0;

  for c in line:gmatch("%s") do
    if c == "\t" then
      indent = indent + sw
    else
      indent = indent + 1
    end
  end

  return indent
end

local function indent()
  local cursor = v.nvim_win_get_cursor(0)
  local line = v.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]

  local indentexpr = v.nvim_buf_get_option(0, "indentexpr")
  local expand = v.nvim_buf_get_option(0, "expandtab")
  local shiftwidth = v.nvim_eval("shiftwidth()")
  local tab_char = v.nvim_replace_termcodes("<Tab>", true, true, true)
  local indent_goal = treesitter.get_indent(line)

  if indent_goal == -1 then
    if indentexpr ~= "" then
      indent_goal = v.nvim_eval(indentexpr)
    elseif v.nvim_buf_get_option(0, "cindent") then
      indent_goal = v.nvim_call_function("cindent", {cursor[1]})
    else
      indent_goal = v.nvim_call_function("indent", {cursor[1]})
    end
  end

  if indent_goal == -1 and cursor[1] ~= 1 then
    local prev_line = v.nvim_buf_get_lines(0, cursor[1] - 2, cursor[1] - 1, false)[1]
    indent_goal = get_line_indent(prev_line, shiftwidth)
  end

  -- Reset the cursor, since the functions are free to move it
  v.nvim_win_set_cursor(0, cursor)

  if cursor[2] == 0 and line == "" and indent_goal > 0 then
    local i = 0
    while i < indent_goal do
      if expand then
        v.nvim_feedkeys(" ", 'n', true)
        i = i + 1
      else
        v.nvim_feedkeys(tab_char, 'n', true)
        i = i + shiftwidth
      end
    end
    print(i, indent_goal)
  else
    v.nvim_feedkeys(tab_char, 'n', true)
  end
end

return {indent = indent}
