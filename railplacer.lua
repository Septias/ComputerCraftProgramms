local normalRailSlot = 1
local advancedRailSlot = 2
local torchSlot = 3


local function back()
    while not turtle.back() do
        sleep(1)
    end
end


for section=1, 10 do  -- = 270 Blocks --
    missingrails = turtle.getItemSpace()
    
    -- shift rails to have a full stack --
    for i=13, 5, -4 do
        turtle.select(i)
        turtle.transferTo(i - 4, missingrails)
    end
    turtle.select(normalRailSlot)

    -- cancel if there are no rails to place --
    if turtle.getItemSpace() == 64 then
        return
    end

    for step=1, 26 do -- 27 is the perfect space --
        back()
        turtle.place()
    end
    turtle.turnLeft()
    turtle.dig()
    turtle.select(torchSlot)
    turtle.place()
    turtle.turnRight()
    turtle.back()
    turtle.select(advancedRailSlot)
    turtle.place()
end


