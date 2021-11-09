os.loadAPI('/blink/strings.lua')

function parseFlags(args)
  local commands = {}
  local flags = {}

  for _, a in ipairs(args) do
    local flag, value = a:match('^-{1,2}([a-zA-Z_]+)=?(.*)')

    if flag then
      flags[flag] = (((value == 'true') and true) or ((value == 'false') and false)) or ((value ~= false) and value)
    elseif a then
      table.insert(commands, a)
    end
  end

  return commands, flags
end
