Edge = { head = false, tail = false, direction = false }

function Edge:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return Edge
