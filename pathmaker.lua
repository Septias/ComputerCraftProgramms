dh = require("dighelpers")

length = 128
width = 2

for x=1, length do
    
    if turtle.getItemCount() < width +2 then
        for slot=16, 2, -1 do
            turtle.select(slot)
            turtle.transferTo(1)
        end
    end


    turtle.select(1)
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.placeDown()
    if width > 1 then
        dh.makestep()
    end
end
