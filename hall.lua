dh = require("dighelpers")

for i=0, 300 do
    dh.digForward()
    turtle.digUp()
    if not turtle.detectDown() then
        turtle.placeDown()
    end
end
  
