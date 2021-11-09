local Inspection = require('inspection')
local Inspector = require('visitors.inspector')

Device = { node = false, heading = false, ws = false }

function Device:new(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  self.type = 'Device'

  return o
end

function Device:inspect()
  for _, face in ipairs({
    'front',
    -- 'top',
    -- 'bottom',
    'left',
    'right',
    'back'
  }) do
    local success = false
    local inspect = {}
    local position = Position:new({ x = self.node.position.x, y = self.node.position.y, z = self.node.position.z })

    if face == 'front' then
      success, inspect = turtle.inspect()
      position.z = position.z - 1
    -- elseif face == 'top' then
    --   success, inspect = turtle.inspectUp()
    --   position.y = position.y + 1
    -- elseif face == 'bottom' then
    --   success, inspect = turtle.inspectDown()
    --   position.y = position.y - 1
    elseif face == 'left' then
      turtle.turnLeft()
      success, inspect = turtle.inspect()
      position.x = position.x - 1
      turtle.turnRight()
    elseif face == 'right' then
      turtle.turnRight()
      success, inspect = turtle.inspect()
      position.x = position.x + 1
      turtle.turnLeft()
    elseif face == 'back' then
      turtle.turnLeft()
      turtle.turnLeft()
      success, inspect = turtle.inspect()
      position.z = position.z + 1
      turtle.turnRight()
      turtle.turnRight()
    end

    local inspection = false
    if success then
      inspection = Inspection:new(inspect)
    end

    self.node:attachEdge(face, Node:new({ position = position, inspection = inspection }))
  end
end

-- function Device:lookNorth()
--   if self.heading == 'e' then
--     turtle.turnLeft()
--   elseif self.heading == 's' then
--     turtle.turnLeft()
--     turtle.turnLeft()
--   elseif self.heading == 'w' then
--     turtle.turnRight()
--   end

--   self.heading = 'n'
-- end

-- function Device:forward()
--   if self.heading == 'n' then
--     self.node = self.node.front.tail
--   if self.heading == 'e' then
--     self.node = self.
--   end

--   turtle.forward()
-- end

-- function Device:turnLeft()
--   turtle.turnLeft()
-- end

-- function Device:turnRight()
--   turtle.turnRight()
-- end

-- function Device:turnAround()
--   self:turnLeft()
--   self:turnLeft()
-- end

function Device:findNextInspectable()
  return self.node:accept(Inspector:new())
end

function Device:follow(route)
end

function Device:scan(graph)
  self.node = graph.root

  self:inspect()

  local inspectable = self:findNextInspectable()

  print('inspectable', inspectable)
  for i, r in pairs(inspectable) do
    print(i, r)
  end

  -- You were working out how to iterate a route list of movements
  if inspectable.route then
    for i, r in pairs(inspectable.route) do
      print('route i', i, 'r', r, r.type, 'coords', r.position.x, r.position.y, r.position.z, 'to', self.node.position.x, self.node.position.y, self.node.position.z, r == self.node)
    end
  end

  -- self:follow(route)

  -- self:inspect()
  -- self:forward()
  -- self.node = self.node.front.tail
  -- self:inspect()
end

return Device
