

function forward()
    local x = turtle.forward()
    if (x == false) then
          return forward()
    end
end
  
local function clear(column,row)
term.clear()
if column == nil and row == nil then
    column = 1
    row = 1
elseif row == nil then
    row = 1
elseif column == nil then
    column = 1
end
term.setCursorPos(column,row)