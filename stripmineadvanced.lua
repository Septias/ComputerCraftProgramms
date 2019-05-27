local digHelpers = require("dighelpers")
-- Stripminingprogram to Stripmine whole lodes and transport items back via BuildCraft Pipes --


-- Initializing for Mining --
local totalRows = 5
local hallLength = 5
local torchCounter
local torchSpace = 8


-- selecting slots for Turtle -- 
local torchSlot = 16

local stonepipeslot = 13
local obspipeslot = 14



local function cleaninv()
	for i=1, 9 do
		turtle.select(i)
		for b=0, 9 do
			turtle.drop(8)
		end
	end
	turtle.suck()
end


local function placeTorch()
	turtle.select(torchSlot)
	if turtle.getItemDetail().name == "minecraft:torch" then
		turtle.place()
	end
end


local function dig(length)
	turtle.select(1)

	for i=1, length do
		digHelpers.go()
		-- place torches every <torchSpace> blocks --
		if math.fmod(i, torchSpace) == 0 then 
			if not turtle.detectDown() then
				turtle.turnLeft()
				turtle.turnLeft()
				placeTorch()
				turtle.turnLeft()
				turtle.turnLeft()
			end
		end
	end
end

local function digHall()
	dig(hallLength)
	turtle.turnLeft()
	turtle.turnLeft()
	placeTorch()
	digHelpers.digUp()
	dig(hallLength - 1)

	turtle.forward()
	turtle.digDown()
	turtle.down()
end


local function digHalls()
	-- starts looking ahead and ends looking behind ! --

	turtle.select(1)
	-- dig left hall --
	turtle.turnLeft()
	digHall()

	-- dig right hall --
	digHall()

	-- turn left to drop items into pipes --
	turtle.turnLeft()
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


function dignplace(length)
	for i=1, length do
		-- place pipe -- 
		if i < length - 1 then
			turtle.select(stonepipeslot)
			turtle.digDown()
			turtle.placeDown()
		else 
			turtle.select(obspipeslot)
			turtle.digDown()
			turtle.placeDown()
		end
		-- go forward --
		turtle.select(1)
		digHelpers.go()
		turtle.digUp()
	end
end


-- Main Loop --
for i=1, totalRows do
	dignplace(3) 
	digHalls()
	cleaninv()
	-- take up lila pipes --
	turtle.select(obspipeslot)
	turtle.forward()
	turtle.digDown()
	turtle.forward()
	turtle.digDown()
	-- place down the two remaining pipes --
	turtle.select(stonepipeslot)
	turtle.placeDown()
	turtle.back()
	turtle.placeDown()
	turtle.back()
	turtle.placeDown()
	turtle.turnLeft()
	turtle.turnLeft()
end

print("Mining Completed")