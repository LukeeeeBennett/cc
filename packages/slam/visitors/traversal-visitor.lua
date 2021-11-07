TraversalVisitor = {}

function TraversalVisitor:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.type = 'TraversalVisitor'
  return o
end

function TraversalVisitor:visitGraph(graph)
  graph.root:accept(self)
end

function TraversalVisitor:visitEdge(edge)
  for i, name in ipairs(edge.names) do
    edge[name]:accept(self)
  end
end

function TraversalVisitor:visitNode(node)
  for i, face in ipairs(node.faces) do
    if node.inspection then
      node.inspection:accept(self)
    end

    if node.position then
      node.position:accept(self)
    end

    node[face]:accept(self)
  end
end

function TraversalVisitor:visitInspection(inpsection)
end

function TraversalVisitor:visitPosition(position)
end

return TraversalVisitor
