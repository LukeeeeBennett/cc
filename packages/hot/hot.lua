os.loadAPI('/blink/base64.lua')
os.loadAPI('/blink/strings.lua')
os.loadAPI('/blink/cli.lua')

args = {...}

local commands, flags = cli.parseFlags(args)

Hot = {
  url = commands[0],
  autorun = flags.autorun,
  ignore = flags.ignore,
  ws = false
}

function Hot:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Hot:init()
  local current = ''
  local handler = false

  if fs.exists('.hot/url') then
    handler = fs.open('.hot/url', 'r')
    current = handler.readLine()
    handler.close()
  end

  local nextUrl = self.url or current

  local ws = http.websocket(nextUrl)

  self.ws = ws

  handler = fs.open('.hot/url', 'w')
  handler.write(nextUrl)
  handler.close()
end

function Hot:listen()
  self:init()

  print('Listening...')

  local _, _, message
  repeat
    _, _, message = os.pullEvent('websocket_message')
    local split = self:split(message, ':')
    local name = base64.decode(split[2])
    local content = base64.decode(split[3])

    if self.ignore and name:match(self.ignore) then
      print('Ignoring', name)
    else
      self:writeFile(name, content)
      print('Reloaded', name)

      if self.autorun and strings.endsWith(name, '.lua') then
        if self.autorun == '--autorun' then
          self:runFile(name)
        elseif strings.startsWith(self.autorun, '--autorun=') then
          self:runFile(self.autorun:sub((#'--autorun=') + 1, #self.autorun))
        end
      end
    end
  until false

  self.ws.close()
end

function Hot:writeFile(name, content)
  local handler = fs.open(name, 'w')
  handler.write(content)
  handler.close()
end

function Hot:runFile(name)
  print('Running', name)
  shell.run(name)
end

function Hot:split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match)
  end

  return result
end


function main()
  local hot = Hot:new()

  return hot:listen()
end

main()
