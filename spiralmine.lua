digHelpers = require("digHelpers")

-- variables --
local startlength = 5
local increase = 3
local halls = 10


for hall=0, halls-1 do
    digHelpers.dig(startlength + (increase * i))
    turtle.turnLeft()
end

turtle.turnLeft()
turtle.turnLeft()
turtle.goUp()

startlength = startlength + (increase * halls)

for hall=0, halls-1 do
    digHelpers.walk(startlength  - (increase * i))
    turtle.turnRight()
end