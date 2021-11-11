Inspector = {
  visited = {},
}

function Inspector:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Inspector'

  return o
end

function Inspector:generateID(node)
  if not node or not node.position then
    return node
  end

  return node.position.x .. ',' .. node.position.y .. ',' .. node.position.z
end

function Inspector:trackVisit(node)
  self.visited[self:generateID(node)] = true
end

function Inspector:hasVisited(node)
  return self.visited[self:generateID(node)] == true
end

function Inspector:resetVisited()
  for k in pairs(self.visited) do
      self.visited[k] = nil
  end
end

function Inspector:find(node, r, ch)
  local route = r or {}

  if ch then
    node = ch
    print('insert child', node)
    table.insert(route, node)
  end

  local id = self:generateID(node)

  local children = node:getChildren()

  if not self:hasVisited(node) then
    local inspectableFaces = self:canInspect(children)

    if inspectableFaces and #inspectableFaces > 0 then
      self:trackVisit(node)
      return node, inspectableFaces, route
    end
  end

  for f, child in pairs(children) do
    local childId = self:generateID(child)

    if self:isPassable(child) and not self:isLoop(child, route) then
      -- print(id, 'to', childId)

      local a, b, c = self:find(node, route, child)

      if a and b and c then
        return a, b, c
      end
    end
  end
end

function Inspector:canInspect(children)
  local res = {}

  for face, child in pairs(children) do
    if child == false then
      table.insert(res, face)
    end
  end

  return res
end

function Inspector:isPassable(node)
  return node and node.inspection == false
end

function Inspector:isLoop(node, route)
  for _, step in ipairs(route) do
    if step == node then
      return true
    end
  end

  return false
end

return Inspector
