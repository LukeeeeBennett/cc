local utils = require('utils')

function PositionSerializer(position)
  local body = ''

  local isFirst = true
  for _, axis in ipairs(position.axes) do
    local delimit = ((isFirst and '') or ',')
    isFirst = false

    body = body .. delimit .. ' "' .. axis .. '": ' .. utils.string_or_boolean(position[axis])
  end

  return '{ ' .. body .. ' }'
end

return PositionSerializer
