local v = vim.api

local function indent()
  local cursor = v.nvim_win_get_cursor(0)
  local line = v.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]

  -- TODO: support noexpand
  -- TODO: Figure out when to use indent() and when to use cindent()
  -- TODO: Problem with the C-O bind, because it brings the cursor back to start
  local indent_goal = v.nvim_call_function("cindent", {cursor[1] + 1})

  if cursor[2] == 0 and line == "" and indent_goal ~= 0 then
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
