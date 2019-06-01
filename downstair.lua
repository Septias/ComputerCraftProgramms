dh = require("dighelpers")


depth = 57
width = 2
space = 2


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
    dh.down()

    turtle.placeDown()
    dh.makestep()
    if space > 1 then
        for steps=1, space - 1 do
            turtle.dig()
            turtle.forward()
            turtle.digUp()
            turtle.placeDown()
            dh.makestep()
        end
    end
end
