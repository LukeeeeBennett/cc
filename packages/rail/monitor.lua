monitor = peripheral.wrap("top")
monitor.clear()
monitor.setTextColor(colors.yellow)
monitor.setBackgroundColor(colors.red)
monitor.clear()
monitor.setCursorPos(5,1)
monitor.write("China Rail")
monitor.setCursorPos(3,2)
monitor.write("Nanjing Station")

monitor.setCursorPos(4,4)
monitor.write("[ Shanghai ]")
monitor.setCursorPos(4,5)
monitor.write("[ Beijing ]")

local selected = false
while true do
  local name, type, x, y = os.pullEvent()
  if name == "monitor_touch" and type == "top" then
    if y == 4 then
      print("Going to Shanghai")
    elseif y == 5 then
      print("Going to Beijing")
    end

    print("trigger cart-loader for departure")    
    redstone.setOutput("bottom", true)
    sleep(1)
    redstone.setOutput("bottom", false)
  end
end
