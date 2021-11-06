local Graph = require('graph')

args = {...}

local command = args[1]
local url = args[2]

Slam = { graph = Graph:new(), ws = false }

function Slam:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Slam:connect(url)
  local handler = fs.open('.slam/url', "r" and "w")
  local current = handler.readAll()
  local newUrl = url or self.url

  self.ws = http.websocket(newUrl or current)

  if (current !== newUrl) then
    handler.write(newUrl)
    handler.close()
  end
end

function Slam:scan()
  rootNode = self.graph:init()

  local front = Node:new({ inspectionData = turtle.inspect()  })
  local top = Node:new({ inspectionData = turtle.inspectUp()  })
  local bottom = Node:new({ inspectionData = turtle.inspectUp()  })

  rootNode:attachEdge('front', front)
  rootNode:attachEdge('top', top)
  rootNode:attachEdge('bottom', bottom)

  turtle.forward()

  local currentFront = Node:new({ inspectionData = turtle.inspect()  })
  local currentTop = Node:new({ inspectionData = turtle.inspectUp()  })
  local currentBottom = Node:new({ inspectionData = turtle.inspectUp()  })

  local currentNode = rootNode.front.tail

  currentNode:attachEdge('front', currentFront)
  currentNode:attachEdge('top', currentTop)
  currentNode:attachEdge('bottom', currentBottom)

  print(rootNode)

  print()
  print('node:')
  print('  front:', rootNode.front)
  print('      next-front:', currentNode.front)
  print('  back:', rootNode.back)
  print('      next-back:', currentNode.back)
  print('  top:', rootNode.top)
  print('      next-top:', currentNode.top)
  print('  bottom:', rootNode.bottom)
  print('      next-bottom:', currentNode.bottom)
  print('  left:', rootNode.left)
  print('      next-left:', currentNode.left)
  print('  right:', rootNode.right)
  print('      next-right:', currentNode.right)
  print()

  turtle.turnLeft()
  turtle.turnLeft()
end

function main()
  slam = Slam:new()

  if command == 'server' then
    slam:connect(url)
    return
  end

  slam:connect()
  return slam:scan()
end

main()
