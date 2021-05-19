local v = vim.api

local function indent()
  local cursor = v.nvim_win_get_cursor(0)
  local line = v.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]

  -- TODO: support noexpand
  local indentexpr = v.nvim_buf_get_option(0, "indentexpr")
  local expand = v.nvim_buf_get_option(0, "expandtab")
  local indent_goal

  -- TODO: Support treesitter indent
  if indentexpr ~= "" then
    indent_goal = v.nvim_eval(indentexpr)
  elseif v.nvim_buf_get_option(0, "cindent") then
    indent_goal = v.nvim_eval("cindent(v:lnum)")
  else
    indent_goal = v.nvim_eval("indent(v:lnum)")
  end

  -- TODO: Support indent_goal = -1, which means that we keep the previous
  -- indentation
  if cursor[2] == 0 and line == "" and indent_goal > 0 and expand then
    local i = 0
    while i < indent_goal do
      v.nvim_feedkeys(" ", 'n', true)
      i = i + 1
    end
  else
    local tab_char = v.nvim_replace_termcodes("<Tab>", true, true, true)
    v.nvim_feedkeys(tab_char, 'n', true)
  end
end

return {indent = indent}
