Collection = { elements = {}, current = false, position = 0 }

function Collection:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Collection'
  self.current = o.current or o.elements[o.position]

  return o
end

function Collection:getNext()
  local hasMore = self:hasMore()

  if hasMore then
    self.position = self.position + 1
    self.current = self.elements[self.position]

    return self.current
  else
    return hasMore
  end
end

function Collection:hasMore()
  return self.position < (#self.elements)
end

return Collection
