redstone.setOutput("back", true)

while true do
  sleep(0.5)
  local signal = redstone.getInput("right")
  if signal == true then
    redstone.setOutput("back", false)
    turtle.suckDown()
    turtle.forward()
    turtle.up()
    turtle.up()
    turtle.select(1)
    turtle.place()
    redstone.setOutput("front", true)
    sleep(5)
    redstone.setOutput("front", false)
    turtle.down()
    turtle.down()
    turtle.back()
    redstone.setOutput("back", true)
  elseif signal == "arrival" then
    turtle.forward()
    turtle.up()
    turtle.up()
    turtle.attack()
    turtle.attack()
    turtle.suck()
    turtle.down()
    turtle.down()
    turtle.back()
    turtle.dropDown()
  end
end
