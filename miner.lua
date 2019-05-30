

for x = 1, 5 do
    for y=1, 30 do
        turtle.dig()
        turtle.forward()
    end
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    for y=1, 30 do
        turtle.dig()
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
end
