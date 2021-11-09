local utils = require('utils')

function InspectionSerializer(inspection)
  local body = ''

  for i, key in ipairs(inspection.tableKeys) do
    local delimit = ((i == 1 and '') or ',')

    body = body .. delimit .. ' "' .. key .. '": {'

    local isFirst = true
    for k, value in pairs(inspection[key]) do
      if value then
        local innerDelimit = ((isFirst and '') or ',')
        isFirst = false

        body = body .. innerDelimit .. ' "' .. k .. '": ' .. utils.string_or_boolean(value)
      end
    end

    body = body .. '}'
  end

  local name = utils.string_or_boolean(inspection.name)

  return '{ "name": ' .. name .. ', ' .. body .. ' }'
end

return InspectionSerializer
