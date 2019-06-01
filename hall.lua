dh = require("dighelpers")

for i=0, 300 do
    dh.forward()
    turtle.digUp()
    if not turtle.detectDown() then
        turtle.placeDown()
    end
end
  
