Node = {front = false, back = false, left = false, right = false, top = false, bottom = false, inspectionData = false}

function Node:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Node:init()
end

return Node
