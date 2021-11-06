os.loadAPI('/blink/base64.lua')
os.loadAPI('/blink/strings.lua')

args = {...}

Hot = {
  url = args[1],
  autorun = args[2],
  ws = false
}

function Hot:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Hot:init()
  local handler = fs.open('.hot/url', 'r')
  local current = handler.readLine()
  handler.close()
  handler = fs.open('.hot/url', 'w')

  local nextUrl = self.url or current

  self.ws = http.websocket(nextUrl)

  handler.write(nextUrl)
  handler.close()
end

function Hot:listen()
  self:init()

  print('Listening...')

  local event, url, message
  repeat
    event, url, message = os.pullEvent('websocket_message')
    local split = self:split(message, ':')
    local key = split[1]
    local name = base64.decode(split[2])
    local content = base64.decode(split[3])

    self:writeFile(name, content)
    print('Synced', name)

    if self.autorun and strings.endsWith(name, '.lua') then
      if self.autorun == '--autorun' then
        self:runFile(name)
      elseif strings.startsWith(self.autorun, '--autorun=') then
        self:runFile(self.autorun:sub((#'--autorun=') + 1, #self.autorun))
      end
    end
  until false
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
  hot = Hot:new()

  return hot:listen()
end

main()
