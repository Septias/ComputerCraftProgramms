digHelpers = require("digHelpers")

-- variables --
local startlength = 3
local increase = 3
local halls = 3



local halls = halls - 1


for hall=0, halls do
    digHelpers.digHall(startlength + (increase * hall))
    turtle.turnLeft()
end

turtle.turnLeft()
turtle.up()

startlength = startlength + (increase * halls)

for hall=0, halls do
    digHelpers.walk(startlength  - (increase * hall))
    turtle.turnRight()
end