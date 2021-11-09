function EdgeSerializer(visitor, edge, parent)
  local body = ''

  for i, name in ipairs(edge.names) do
    local res = 'false'

    if edge[name] == parent then
      res = '"[ CIRCULAR ]"'
    elseif edge[name] then
      res = edge[name]:accept(visitor, edge)
    end

    local delimit = ((i == 1 and '') or ',')

    body = body .. delimit .. ' "' .. name .. '": ' .. res
  end

  return '{ "direction": "' .. edge.direction .. '", ' .. body .. ' }'
end

return EdgeSerializer
