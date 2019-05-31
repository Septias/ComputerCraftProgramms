dh = require("dighelpers")


depth = 57
width = 2
space = 2



function makestep()
    turtle.placeDown()
    if width > 1 then
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

    
    turtle.forward()
    dh.digDown()

    makestep()
    if space > 1 then
        for steps=1, space - 1 do
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.placeDown()
            makestep()
        end
    end
end
