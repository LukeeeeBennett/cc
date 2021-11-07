local utils = {}

function utils.string_or_boolean(value)
  return (type(value) == 'string' and '"' .. value .. '"') or tostring(value)
end

return utils
