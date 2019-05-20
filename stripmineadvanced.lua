
-- Stripminingprogram to Stripmine whole lodes and transport items back via BuildCraft Pipes --


-- Initializing for Mining --
local totalRows = 5
local hallLength = 5
local torchCounter
local torchSpace = 8


-- selecting slots for Turtle -- 
local torchslot = 16
local stoneslot = 11
local stonepipeslot = 13
local obspipeslot = 14
local glassslot = 10


-- falling blocks --
local fBlocks = {
	"minecraft:sand",
	"minecraft:gravel",
	"minecraft:anvil",
	"minecraft:dragon_egg"
}


local function fallingBlock(name)
	for i=1, #fBlocks do
		if name == fBlocks[i] then
			return true
		else 
			return false
		end
	end 
end

function walk(length)
	for i=1, length do
		turtle.forward()
	end
end


function placetorch()
	if torchCounter > 0 then
		turtle.up()
		turtle.select(16)
		turtle.place()
		torcheCounter = torchCounter - 1
		turtle.down()
		turtle.select(1)
	end
end


function cleaninv()
	for i=1, 9 do
		turtle.select(i)
		for b=0, 9 do
			turtle.drop(8)
		end
	end
	turtle.suck()
end


local function dig(length, back)
	turtle.select(1)
	local depth = 0
	local _torchspace = 0
	for i=0, length do
		local success, data = turtle.inspect()
		if fallingBlock(data.name) then
			-- dog until all gravel dropped 
			while fallingBlock(data.name) do
				turtle.dig()
				sleep(1)
			end
		elseif data.name ~= "minecraft:air" then
			turtle.dig()
		end
		turtle.forward()
		_torchspace = _torchspace + 1
		turtle.digUp()
		if _torchspace > torchSpace then
			placetorch()
			_torchspace = 0
		end
	end
	if back == true then
		turtle.turnLeft()
		turtle.turnLeft()
		
		if length < torchSpace then
			placetorch()
		end
		walk(length)
	end
end


function walknplace(length)
	turtle.select(stonepipeslot)

	for i=0, length do
		local success, data = turtle.inspect()
		
		if fallingBlock(data.name) then
			while fallingBlock(data.name) do
				turtle.dig()
				sleep(1)
			end
		elseif data.name ~= "minecraft:air" then
			turtle.dig()
		end
		
		if i < length - 1 then
			turtle.digDown()
			turtle.placeDown()
		else 
			turtle.select(obspipeslot)
			turtle.digDown()
			turtle.placeDown()
		end
		turtle.forward()
		turtle.digUp()
	end
end


turtle.select(16)
torchCounter = turtle.getItemCount()
if torchChounter then
	if turtle.getItemDetail().name ~= "minecraft:torch" then
		print("No torches given")
		torchChounter = 0
	else
		print("You have " + torchCounter " torches")
	end
end 


-- Main Loop --
for i=1, totalRows do
	walknplace(3) 
	turtle.turnLeft()
	dig(hallLength,true)
	dig(hallLength,true)
	turtle.turnLeft()
	cleaninv()
	-- take up lila pipes --
	turtle.select(obspipeslot)
	turtle.forward()
	turtle.digDown()
	turtle.forward()
	turtle.digDown()
	-- place down the tow remaining slots --
	turtle.select(stonepipeslot)
	turtle.placeDown()
	turtle.back()
	turtle.placeDown()
	turtle.back()
	turtle.turnLeft()
	turtle.turnLeft()
end

print("Mining Completed")
