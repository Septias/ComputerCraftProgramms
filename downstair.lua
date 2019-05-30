dh = require("dighelpers")


depth = 57
width = 2
space = 2


function go()
    turtle.placeDown()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.placeDown()

    if width > 1 then
        makestep()
    end
end

function makestep(width)
    turtle.turnRight()
    for y=1, width-1 do
        go()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for i=1, width-1 do
        turtle.forward()
    end
    turtle.turnRight()
end


for x=1, depth do

    -- shifting items to first slot --
    if turtle.getItemCount() < width +2 then
        for slot=16, 2, -1 do
            turtle.select(slot)
            turtle.transferTo(1)
        end
    end
    turtle.select(1)
    
    -- begining to build --

    go()
    turtle.forward()
    dh.digDown()

    for steps=1, space do
        go()
    end
    turtle.forward()
    dh.digDown()
end
