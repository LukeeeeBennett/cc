Traversal = {}

function Traversal:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Traversal'

  return o
end

function Traversal:visitGraph(graph)
  if graph.root then return graph.root:accept(self) end

  return graph.root
end

function Traversal:visitEdge(edge, parent)
  local res = {}

  for _, name in ipairs(edge.names) do
    if edge[name] and edge[name] ~= parent then
      res[name] = edge[name]:accept(self, edge)
    end
  end

  return res
end

function Traversal:visitNode(node, parent)
  local res = {}

  if node.inspection then
    node.inspection:accept(self)
  end

  if node.position then
    node.position:accept(self)
  end

  for _, face in ipairs(node.faces) do
    if node[face] and node[face] ~= parent then
      res[face] = node[face]:accept(self, node)
    end
  end

  return res
end

function Traversal:visitInspection(inpsection)
end

function Traversal:visitPosition(position)
end

return Traversal
