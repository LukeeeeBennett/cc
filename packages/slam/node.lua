local Edge = require('edge')

Node = {
  front = false,
  back = false,
  left = false,
  right = false,
  top = false,
  bottom = false,
  inspection = false,
  position = false
}

function Node:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.type = 'Node'
  self.faces = {'front', 'back', 'left', 'right', 'top', 'bottom'}
  return o
end

function Node:accept(visitor)
  visitor:visitNode(self)
end

function Node:attachEdge(face, to)
  local edge = Edge:new({ head = self, tail = to })

  if face == 'front' then
    self.front = edge;
    to.back = edge;
  elseif face == 'back' then
    self.back = edge;
    to.front = edge;
  elseif face == 'left' then
    self.left = edge;
    to.right = edge;
  elseif face == 'right' then
    self.right = edge;
    to.left = edge;
  elseif face == 'top' then
    self.top = edge;
    to.bottom = edge;
  elseif face == 'bottom' then
    self.bottom = edge;
    to.top = edge;
  end
end

function Node:serialize(parent)
  local body = ''

  for i, face in ipairs(self.faces) do
    local res = 'false'

    if self[face] == parent then
      res = '"circular"'
    elseif self[face] then
      res = self[face]:serialize(self)
    end

    local delimit = (( i == 1 and '') or ',')

    body = body .. delimit ..' "' .. face .. '": ' .. res
  end

  return '{ "inspection": "' .. ((self.inspection and self.inspection:serialize()) or tostring(self.inspection)) .. ', ' .. body .. ' }'
end

return Node
