
-- Program to mine a whole lode by Sebastian Klähn --


-- blocks to mine --
local mBlocks = {
    "minecraft:coal_ore",
    "minecraft:iron_ore"
}


-- falling blocks --
local fBlocks = {
    "minecraft:sand",
    "minecraft:gravel", 
    "minecraft:anvil", 
    "minecraft:dragon_egg"
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


local function digUp()
    while turtle.detectUp() do
        turtle.digUp()
        sleep(1.0)
    end
    turtle.up()
end


local function isFallingBlock(name)
    for i=1, #fBlocks do
        if name == fBlocks[i] then
            return true
        else 
            return false
        end
    end 
end

    
local function digForward()
    local success, data = turtle.inspect()
    if isFallingBlock(data.name) then
        while isFallingBlock(data.name) do
            turtle.dig()
            sleep(1)
        end
    elseif data.name ~= "minecraft:air" then
        turtle.dig()
    end
    turtle.forward()
end

-- actual digginglogic -- 
function go(direction)

    -- go in some direction --
    print("looking for a direction to go")
    if direction == "up" then
        print("going up")
        digUp()

    elseif direction == "down" then
        print("going down")
        turtle.digDown()
        turtle.down()
    else
        print("going forward")
        digForward()
    end

    local success, blockup = turtle.inspectUp()
    print("checking Block above me")
    if isToMine(blockup.name) then
        go("up")
        turtle.down()
    end

    local success, blockdown = turtle.inspectDown()
    if isToMine(blockdown.name) then
        go("down")
         -- go back --
         turtle.up()
    end

    local success, blockinfront = turtle.inspect()
    if isToMine(blockinfront.name) then
        go()
         -- go back --
         turtle.back()
    end

    turtle.turnLeft()
    local success, blockleft = turtle.inspect()
    if isToMine(blockleft.name) then
        go()
         -- go back --
         turtle.back()
    end

    turtle.turnRight()
    turtle.turnRight()
    local success, blockright = turtle.inspect()
    if isToMine(blockright.name) then
        go()
         -- go back --
        turtle.back()
    end
    turtle.turnLeft()
end

go()