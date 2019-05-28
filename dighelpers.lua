
-- Program to mine a whole lode by Sebastian Klähn --


-- blocks to mine --
local mBlocks = {
    "minecraft:coal_ore",
    "minecraft:iron_ore",
    "minecraft:gold_ore",
    "minecraft:redstone_ore",
    "minecraft:lapis_ore",
    "emerald_ore",
    "biomsopkenty:gem_ore",
    "ic2:resource"
}


-- block to be announced when found --
local aBlocks = {
    "minecraft:coal_ore",
    "minecraft:diamond_ore",
    "minecraft:redstone_ore",
    "minecraft:lapis_ore",
    "emerald_ore"
}


-- function to cheack wether a block is in the list of Blocks to mine --
local function isToMine(blockname)
    for i=1, #mBlocks do
        if blockname == mBlocks[i] then
            return true
        end
    end
    return false
end


function digUp()
    while not turtle.up() do
        turtle.digUp()
    end
end

    
function digForward()
    while not turtle.forward() do
        turtle.dig()
    end
end


-- actual digginglogic -- 
function go(direction)

    -- go in some direction --
    if direction == "up" then
        digUp()

    elseif direction == "down" then
        turtle.digDown()
        turtle.down()
    else
        digForward()
    end

    local success, blockup = turtle.inspectUp()
    if isToMine(blockup.name) then
        go("up")
        turtle.down()
    end

    local success, blockdown = turtle.inspectDown()
    if isToMine(blockdown.name) then
        go("down")
         turtle.up()
    end

    local success, blockinfront = turtle.inspect()
    if isToMine(blockinfront.name) then
        go()
         turtle.back()
    end

    turtle.turnLeft()
    local success, blockleft = turtle.inspect()
    if isToMine(blockleft.name) then
        go()
         turtle.back()
    end

    turtle.turnRight()
    turtle.turnRight()
    local success, blockright = turtle.inspect()
    if isToMine(blockright.name) then
        go()
        turtle.back()
    end
    turtle.turnLeft()
end


function dignplace(length, slot)
	for i=1, length do
		-- place pipe -- 
        turtle.select(stonepipeslot)
        turtle.digDown()
        turtle.placeDown()

		-- go forward --
		turtle.select(1)
		go()
	end
end

local function walk(length)
    for i=1, length do
        go()
    end
end


local function digHall(length, torches=true)
	turtle.select(1)

	for i=1, length do
        go()
        turtl.digUp()
		-- place torches every <torchSpace> blocks --
		if math.fmod(i, torchSpace) == 0 and torches then 
            turtle.turnLeft()
            turtle.turnLeft()
            placeTorch()
            turtle.turnLeft()
            turtle.turnLeft()
		end
    end
    if torches do 
        turtle.turnLeft()
        turtle.turnLeft()
        placeTorch()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end


return{
    go=go,
    digForward=digForward,
    digUp=digUp,
    walknplace=walknplace,
    walk=walk,
}