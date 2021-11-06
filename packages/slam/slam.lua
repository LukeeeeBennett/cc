local Graph = require('graph')

args = {...}

Slam = { graph = Graph:new() }

function Slam:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Slam:init()
end

function Slam:scan()
  self.graph:init()

  rootNode = self.graph.root

  local front = Node:new({ inspectionData = turtle.inspect()  })
  local top = Node:new({ inspectionData = turtle.inspectUp()  })
  local bottom = Node:new({ inspectionData = turtle.inspectUp()  })

  rootNode.attachEdge('front', front)
  rootNode.attachEdge('top', top)
  rootNode.attachEdge('bottom', bottom)

  turtle.forward()

  currentNode = front

  local currentFront = Node:new({ inspectionData = turtle.inspect()  })
  local currentTop = Node:new({ inspectionData = turtle.inspectUp()  })
  local currentBottom = Node:new({ inspectionData = turtle.inspectUp()  })

  currentNode.attachEdge('front', currentFront)
  currentNode.attachEdge('top', currentTop)
  currentNode.attachEdge('bottom', currentBottom)

  print(rootNode)
end

function main()
  slam = Slam:new()

  return slam:scan()
end

main()
