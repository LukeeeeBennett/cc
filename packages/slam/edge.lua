Edge = {}

function Edge:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Edge:init()
end

return Edge
