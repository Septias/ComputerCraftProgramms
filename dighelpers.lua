
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

local torchSpace = 8


-- function to cheack wether a block is in the list of Blocks to mine --
local function isToMine(blockname)
    for i=1, #mBlocks do
        if blockname == mBlocks[i] then
            return true
        end
    end
    return false
end


function up()
    while not turtle.up() do
        turtle.digUp()
    end
end

    
function forward()
    while not turtle.forward() do
        turtle.dig()
    end
end

function down()
    while not turtle.down() do
        turtle.digDown()
    end
end


function contains(element, array)
    for i=1, #array do
        if array[i] == element then
            return true
        end
    end
    return false
end


-- actual digginglogic -- 
function go(direction, checked_blocks, position)

        
    for x=1, #checked_blocks do
        print(checked_blocks[x])
    end

    -- go in some direction --
    if direction == "up" then
        up()
        position = {position[1], position[2] + 1, position[3]}

    elseif direction == "down" then
        down()
        position = {position[1], position[2] - 1, position[3]}

    else
        forward()
        position = {position[1], position[2], position[3] + 1}
    end


    local success, blockup = turtle.inspectUp()
    checked_blocks[#checked_blocks + 1] = {position[1], position[2] + 1, position[3]}
    if isToMine(blockup.name) then
        go("up", checked_blocks, position)
        turtle.down()
    end

    local success, blockdown = turtle.inspectDown()
    checked_blocks[#checked_blocks + 1] = {position[1], position[2] - 1, position[3]}
    if isToMine(blockdown.name) then
        go("down", checked_blocks, position)
        turtle.up()
    end
    
    local success, blockinfront = turtle.inspect()
    checked_blocks[#checked_blocks + 1] = {position[1], position[2], position[3] + 1}
    if isToMine(blockinfront.name) then
        go("forward", checked_blocks, position)
        turtle.back()
    end

    if not contains({position[1] - 1, position[2], position[3]}, checked_blocks) then
        turtle.turnLeft()
        local success, blockleft = turtle.inspect()
        checked_blocks[#checked_blocks + 1] = {position[1] - 1, position[2], position[3]}
        if isToMine(blockleft.name) then
            go("forward", checked_blocks, position)
            turtle.back()
        end
        turtle.turnRight()
    end
    
    if not contains({position[1] + 1, position[2], position[3]}, checked_blocks) then
        turtle.turnRight()
        local success, blockright = turtle.inspect()
        checked_blocks[#checked_blocks + 1] = {position[1] + 1, position[2], position[3]}
        if isToMine(blockright.name) then
            go("forward", checked_blocks, position)
            turtle.back()
        end
        turtle.turnLeft()
    end

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


local function placeTorch(slot)
    turtle.select(slot)
    turtle.place()
    turtle.select(1)
end

local function digMiningHall(length, securepath)
	turtle.select(1)

	for i=1, length do
        go()
        if not turtle.detectDown() and securepath then
            turtle.placeDown()
        end
        turtle.digUp()
		-- place torches every <torchSpace> blocks --
		if math.fmod(i, torchSpace) == 0 then 
            turtle.turnLeft()
            turtle.turnLeft()
            placeTorch(16)
            turtle.turnLeft()
            turtle.turnLeft()
		end
    end
    turtle.turnLeft()
    turtle.turnLeft()
    placeTorch(16)
    turtle.turnLeft()
    turtle.turnLeft()
end


function makestep(width)
    turtle.turnRight()
    for y=1, width-1 do
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.placeDown()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for i=1, width-1 do
        turtle.forward()
    end
    turtle.turnRight()
end


return{
    digMiningHall=digMiningHall,
    walknplace=walknplace,
    walk=walk,
    go=go,
    up=up,
    forward=forward,
    down=down
}