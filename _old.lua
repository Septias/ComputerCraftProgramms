

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
end

term.setCursorPos(column,row)

local function placeTorch()
	if torchCounter > 0 then
		turtle.up()
		turtle.select(16)
		turtle.place()
		torcheCounter = torchCounter - 1
		turtle.down()
		turtle.select(1)
	end
end


local function walk(length)
	for i=1, length do
		turtle.forward()
	end
end

local function fallingBlock(name)
	for i=1, #fBlocks do
		if name == fBlocks[i] then
			return true
		else 
			return false
		end
	end 
end
