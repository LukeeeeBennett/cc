Edge = { head = false, tail = false, direction = '<->' }

function Edge:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.type = 'Edge'
  self.names = {'head', 'tail'}
  return o
end

function Edge:accept(visitor)
  visitor:visitEdge(self)
end

function Edge:serialize(parent)
  local body = ''

  for i, name in ipairs(self.names) do
    local res = 'false'
    if self[name] == parent then
      res = '"circular"'
    elseif self[name] then
      res = self[name]:serialize(self)
    end
    body = body .. ', "' .. name .. '": ' .. res
  end

  -- TODO: add direction
  return '{ ' .. body .. ' }'
end

return Edge
