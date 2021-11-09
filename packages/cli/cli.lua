os.loadAPI('/blink/strings.lua')

function parseFlags(args)
  local commands = {}
  local flags = {}

  for _, a in ipairs(args) do
    local flag, value = a:match('^--([a-zA-Z_]+)=(.+)')

    if flag then
      flags[flag] = value
    else
      table.insert(commands, a)
    end
  end

  return commands, flags
end
