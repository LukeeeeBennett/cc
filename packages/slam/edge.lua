Edge = { head = false, tail = false, direction = '<->' }

function Edge:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Edge'
  self.names = {'head', 'tail'}

  return o
end

function Edge:accept(visitor, ...)
  return visitor:visitEdge(self, unpack(arg))
end

return Edge
