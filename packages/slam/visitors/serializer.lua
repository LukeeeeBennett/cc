local GraphSerializer = require('serializers.graph')
local NodeSerializer = require('serializers.node')
local EdgeSerializer = require('serializers.edge')
local InspectionSerializer = require('serializers.inspection')
local PositionSerializer = require('serializers.position')

Serializer = {}

function Serializer:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.type = 'Serializer'

  return o
end

function Serializer:visitGraph(graph)
  return GraphSerializer(self, graph)
end

function Serializer:visitEdge(edge, parent)
  return EdgeSerializer(self, edge, parent)
end

function Serializer:visitNode(node, parent)
  return NodeSerializer(self, node, parent)
end

function Serializer:visitInspection(inspection)
  return InspectionSerializer(inspection)
end

function Serializer:visitPosition(position)
  return PositionSerializer(position)
end

return Serializer
