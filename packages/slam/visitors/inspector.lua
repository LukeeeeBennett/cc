local Traversal = require('visitors.traversal')

Inspector = Traversal:new({})

function Inspector:new(o)
  o = Traversal.new(self, o)
  setmetatable(o, self)
  self.__index = self

  self.type = 'Inspector'

  return o
end

function Inspector:visitGraph(graph)
  return Traversal.visitGraph(self, graph)
end

function Inspector:visitEdge(edge, parent)
  local inspectable = false

  parent.route = parent.route or {}
  table.insert(parent.route, edge)
  edge.route = parent.route

  for _, name in ipairs(edge.names) do
    if edge[name] and edge[name] ~= parent then
      return edge[name]:accept(self, edge)
    end
  end

  if inspectable then
    print('found in edge', inspectable.type)

    inspectable.route = edge.route

    return inspectable
  end

  return false
end

function Inspector:visitNode(node, parent)

  local inspectable = false

  parent.route = parent and parent.route or {}
  table.insert(parent.route, node)
  node.route = parent.route

  for _, face in ipairs(node.faces) do

    if node[face] == false then
      print('break in first')

      inspectable = node
      break
    end
  end

  if inspectable then
    print('found in first')

    for k, v in pairs(inspectable) do
      print('k', k, 'v', v)
    end

    return inspectable
  end

  for _, face in ipairs(node.faces) do
    -- print('checking', face)
    if node[face] ~= parent then
      -- local newNode = Node:new(node)

      local res = node[face]:accept(self, node)

      if res then
        -- print('break in last')

        if inspectable then
          for k, v in pairs(inspectable) do
            -- print('k', k, 'v', v)
          end
        else
          -- print(inspectable)
        end

        inspectable = res
        break
      end
    end
  end

  if inspectable then
    print('found in last')

  for k, v in pairs(inspectable) do
    print('k', k, 'v', v)
  end
    return inspectable
  end

  return false
end

function Inspector:visitInspection(inspection)
  return Traversal.visitInspection(self, inspection)
end

function Inspector:visitPosition(position)
  return Traversal.visitEdge(self, position)
end

return Inspector
