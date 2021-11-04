args = {...}

Hot = {url = args[1], ws = false}

function Hot:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Hot:init()
print(self.url)
  self.ws = http.websocket(self.url)
end

function Hot:listen()
  self:init()

  local event, url, message
  repeat
    event, url, message = os.pullEvent("websocket_message")
    local split = self:split(message, ":")
    local key = split[1]
    local name = split[2]
    local content = split[3]

    self:writeFile(name, content)
    self:runFile(name)
  until false
end

function Hot:writeFile(name, content)
  print('open', name)
  local handler = fs.open(name, "w")
  handler.write(content)
  handler.close()

  print("Reloaded", name)
end

function Hot:runFile(name)
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
