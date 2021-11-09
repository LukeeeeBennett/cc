function GraphSerializer(visitor, graph)
  return '{ "root": ' .. graph.root:accept(visitor) .. ' }'
end

return GraphSerializer
