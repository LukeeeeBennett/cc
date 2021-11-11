local Inspection = require('inspection')
local Inspector = require('iterators.inspector')

Device = { ws = false }

function Device:new(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  self.type = 'Device'

  return o
end

function Device:inspect(heading, node, faces)
  for _, face in ipairs(faces or {
    'front',
    -- 'top',
    -- 'bottom',
    'left',
    'right',
    'back'
  }) do
    local success = false
    local inspect = {}
    local position = Position:new({ x = node.position.x, y = node.position.y, z = node.position.z })

    if face == 'front' then
      heading = self:look(heading, 'n')
      success, inspect = turtle.inspect()
      position.z = position.z - 1
    -- elseif face == 'top' then
    --   success, inspect = turtle.inspectUp()
    --   position.y = position.y + 1
    -- elseif face == 'bottom' then
    --   success, inspect = turtle.inspectDown()
    --   position.y = position.y - 1
    elseif face == 'left' then
      heading = self:look(heading, 'w')
      success, inspect = turtle.inspect()
      position.x = position.x - 1
    elseif face == 'right' then
      heading = self:look(heading, 'e')
      success, inspect = turtle.inspect()
      position.x = position.x + 1
    elseif face == 'back' then
      heading = self:look(heading, 's')
      success, inspect = turtle.inspect()
      position.z = position.z + 1
    end

    local inspection = false
    if success then
      inspection = Inspection:new(inspect)
    end

    local existing = node:getChildren()[face]

    if not existing then
      local newNode = Node:new({ position = position, inspection = inspection })

      node:attachEdge(face, newNode)

      -- check if any other edges to attach
    end
  end

  return heading, node
end

function Device:follow(heading, node, route)
  for _, step in ipairs(route) do
    for _, axis in ipairs(step.position.axes) do
      if not node then
        print('move', node, step, axis, self:generateID(node))
      end

      if step.position[axis] ~= node.position[axis] then

        heading, node = self:move(heading, node, axis, step.position[axis] - node.position[axis])
        print('node afta', heading, node)
      end
    end
  end

  return heading, node
end

function Device:align(heading, axis, value)
  if axis == 'z' then
    if value > 0 then
      heading = self:look(heading, 's')
    else
      heading = self:look(heading, 'n')
    end
  elseif axis == 'x' then
    if value > 0 then
      heading = self:look(heading, 'e')
    else
      heading = self:look(heading, 'w')
    end
  end

  return heading
end

function Device:calcFace(axis, value)
  if axis == 'z' then
    if value > 0 then
      return 'back'
    else
      return 'front'
    end
  elseif axis == 'x' then
    if value > 0 then
      return 'right'
    else
      return 'left'
    end
  end
end

function Device:look(heading, direction)
  local directionMap = { n = 0, s = 2, e = 1, w = 3 }
  local dir = directionMap[direction]
  local head = directionMap[heading]

  local res = head - dir

  local steps = res;
  if res < 0 then
    steps = steps * -1;
  end

  for i = steps, 1, -1 do
    if res < 0 then
      turtle.turnRight()
    elseif res > 0 then
      turtle.turnLeft()
    end
  end

  return direction
end

function Device:move(heading, node, axis, value)
  heading = self:align(heading, axis, value)

  local steps = value

  if value < 0 then
    steps = steps * -1
  end

  for i = steps, 1, -1 do
    turtle.forward()
-- TODO: this is false, but why
-- we shouldnt be routing to some uninspected face mid way through the route. see what is going on there
    node = node:getChildren()[self:calcFace(axis, value)]
  end

  return heading, node
end

function Device:generateID(node)
  if not node or not node.position then
    return node
  end

  return node.position.x .. ',' .. node.position.y .. ',' .. node.position.z
end

function Device:scan(heading, node)
  print('[  -- scan reset -- ] at', self:generateID(node))

  local next, faces, route = Inspector:new():find(node)

  if route and #route > 0 then
    print('follow', #route, heading, node)
    heading, node = self:follow(heading, node, route)
    print('follow ret', #route, heading, self:generateID(node))
  end

  if faces and #faces then
    print('inspect', #faces)
    heading, node = self:inspect(heading, node, faces)
    print('inspect ret', #faces, heading, self:generateID(node))
  end

  print('has more?', route and #route, faces and #faces, heading, self:generateID(node))

  if ((route and #route > 0) or (faces and #faces > 0) or false) then
    return self:scan(heading, node)
  end
end

return Device
