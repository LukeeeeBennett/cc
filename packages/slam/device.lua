local Inspection = require('inspection')

Device = { node = false, heading = false, ws = false }

function Device:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.type = 'Device'
  return o
end

function Device:inspect()
  for i, face in ipairs({'front', 'top', 'bottom'}) do
    local success = false
    local inspect = {}
    local position = Position:new(self.node.position)

    if face == 'front' then
      success, inspect = turtle.inspect()
      position.z = position.z - 1
    elseif face == 'top' then
      success, inspect = turtle.inspectUp()
      position.y = position.y + 1
    elseif face == 'bottom' then
      success, inspect = turtle.inspectDown()
      position.y = position.y - 1
    end

    local inspection = false

    if success then
      inspection = Inspection:new(inspect)
    end

    self.node:attachEdge(face, Node:new({ position = position, inspection = inspection }))
  end
end

function Device:lookNorth()
  if self.heading == 'e' then
    turtle.turnLeft()
  elseif self.heading == 's' then
    turtle.turnLeft()
    turtle.turnLeft()
  elseif self.heading == 'w' then
    turtle.turnRight()
  end

  self.heading = 'n'
end

function Device:forward()
  turtle.forward()
  self.node = self.node.front.tail
end

function Device:scan(graph)
  self.node = graph.root

  self:lookNorth()

  self:inspect()
  self:forward()
  self:inspect()

  -- reset
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.forward()
end

return Device
