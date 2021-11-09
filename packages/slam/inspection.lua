Inspection = {
  name = false,
  tags = false,
  state = false,
}

function Inspection:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Inspection'
  self.tableKeys = {'tags', 'state'}

  return o
end

function Inspection:accept(visitor)
  return visitor:visitInspection(self)
end

return Inspection
