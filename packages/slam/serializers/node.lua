function NodeSerializer(visitor, node, parent)
  local body = ''

  for i, face in ipairs(node.faces) do
    local res = 'false'

    if node[face] == parent then
      res = '"[ CIRCULAR ]"'
    elseif node[face] then
      res = node[face]:accept(visitor, node)
    end

    local delimit = ((i == 1 and '') or ',')

    body = body .. delimit ..' "' .. face .. '": ' .. res
  end

  return '{ "position": ' .. ((node.position and node.position:accept(visitor)) or tostring(node.position)) .. ', "inspection": ' .. ((node.inspection and node.inspection:accept(visitor)) or tostring(node.inspection)) .. ', ' .. body .. ' }'
end

return NodeSerializer
