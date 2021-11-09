os.loadAPI('/blink/base64.lua')

local Graph = require('graph')
local Serializer = require('visitors.serializer')
local Device = require('device')
local Position = require('position')
local Node = require('node')

local args = {...}

local commandArg = args[1]
local firstArg = args[2]
local secondArg = args[3]
local thirdArg = args[4]
local fourthArg = args[5]

Slam = { graph = Graph:new(), ws = false }

function Slam:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.type = 'Slam'
  return o
end

function Slam:connect(url)
  local current = ''
  local handler = false

  if fs.exists('.slam/url') then
    handler = fs.open('.slam/url', 'r')
    current = handler.readLine()
    handler.close()
  end

  local nextUrl = url or current

  local ws = http.websocket(nextUrl)

  self.ws = ws

  handler = fs.open('.slam/url', 'w')
  handler.write(nextUrl)
  handler.close()
end

function Slam:scan(x, y, z, heading)
  local root = Node:new({ position = Position:new({ x = x, y = y, z = z }) })
  local device = Device:new({ node = root, heading = heading })

  self.graph:init(root)

  print('Starting scan...')

  device:scan(self.graph)

  print('Sending scan results...')

  local payload = self.graph:accept(Serializer:new())

  if self.ws and payload then
    self.ws.send('slam:sync:' .. base64.encode(payload))
    print('Scan results sent.')
    self.ws.close()
  end
end

function main()
  local slam = Slam:new()

  if commandArg == 'server' then
    return slam:connect(firstArg)
  elseif commandArg == 'scan' then
    slam:connect()
    return slam:scan(firstArg, secondArg, thirdArg, fourthArg)
  end
end

main()
