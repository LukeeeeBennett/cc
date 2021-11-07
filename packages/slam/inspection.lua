local utils = require('utils')

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
  visitor:visitInspection(self)
end

function Inspection:serialize()
  local body = ''

  for i, key in ipairs(self.tableKeys) do

    body = body .. '"' .. key .. '": {'

    for k, value in pairs(self[key]) do
      if value then
        body = body .. '"' .. k .. '": ' .. utils.string_or_boolean(value)
      end
    end

    body = body .. '}'
  end

  local name = utils.string_or_boolean(self.name)

  return '{ "name": ' .. name .. ', ' .. body .. ' }'
end

return Inspection
