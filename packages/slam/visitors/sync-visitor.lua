local TraversalVisitor = require('visitors.traversal-visitor')
local utils = require('utils')

SyncVisitor = TraversalVisitor:new({})

function SyncVisitor:new(o)
  o = TraversalVisitor.new(self, o)
  setmetatable(o, self)
  self.__index = self
  self.type = 'SyncVisitor'
  return o
end

function SyncVisitor:visitGraph(graph)
  TraversalVisitor.visitGraph(self, graph)
end

function SyncVisitor:visitEdge(edge)
  TraversalVisitor.visitEdge(self, edge)
end

function SyncVisitor:visitNode(node)
  TraversalVisitor.visitNode(self, node)
end

function SyncVisitor:visitInspection(inspection)
  TraversalVisitor.visitInspection(self, inspection)
end

function SyncVisitor:visitPosition(position)
  TraversalVisitor.visitPosition(self, position)
end

return SyncVisitor
