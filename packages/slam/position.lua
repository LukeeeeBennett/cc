local utils = require('utils')

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
  self.axes = {'x', 'y', 'z'}
  return o
end

function Position:accept(visitor)
  visitor:visitPosition(self)
end

function Position:serialize()
  local body = ''

  for axis, value in pairs(self.axes) do
    body = body .. ', "' .. axis .. '": ' .. utils.string_or_boolean(value)
  end

  return '{ ' .. body .. ' }'
end

return Position
