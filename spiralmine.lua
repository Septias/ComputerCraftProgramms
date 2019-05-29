digHelpers = require("digHelpers")

-- variables --
local startlength = 3
local halls = 3


local length = startlength
local halls = halls - 1


digHelpers.digHall(length)
turtle.turnLeft()

for hall=1, halls do
    if math.fmod(hall, 2) == 0 then
        length = length + 2
    else 
        length = length + 1
    end

    digHelpers.digHall(length, true)
    turtle.turnLeft()
end

turtle.turnLeft()
turtle.up()


for hall=halls, 1, -1 do
    digHelpers.digHall(length, false)
    turtle.turnRight()

    if math.fmod(hall, 2) == 0 then
        length = length - 2
    else 
        length = length - 1
    end
end
digHelpers.digHall(startlength, false)
turtle.down()