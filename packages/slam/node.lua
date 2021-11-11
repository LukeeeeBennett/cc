local Edge = require('edge')

Node = {
  front = false,
  back = false,
  left = false,
  right = false,
  -- top = false,
  -- bottom = false,
  inspection = false,
  position = false
}

function Node:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Node'
  self.faces = {
    'front',
    'back',
    'left',
    'right',
    -- 'top', --
    -- 'bottom'--
  }

  return o
end

function Node:accept(visitor, ...)
  return visitor:visitNode(self, unpack(arg))
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
  -- elseif face == 'top' then
  --   self.top = edge;
  --   to.bottom = edge;
  -- elseif face == 'bottom' then
  --   self.bottom = edge;
  --   to.top = edge;
  end
end

function Node:getChildren()
  local res = {}

  for _, face in ipairs(self.faces) do
    res[face] = self[face] and ((self[face].tail ~= self and self[face].tail) or self[face].head)
  end

  return res
end

return Node
