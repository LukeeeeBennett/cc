Position = {
  x = false, -- east
  y = false, -- height
  z = false, -- south
}

function Position:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Position'
  self.axes = {
    'x',
    -- 'y',
    'z',
  }

  return o
end

function Position:accept(visitor)
  return visitor:visitPosition(self)
end

return Position
