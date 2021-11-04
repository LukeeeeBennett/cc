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

  rootNode.front = turtle.inspect()
  rootNode.top = turtle.inspectUp()
  rootNode.bottom = turtle.inspectDown()

  turtle.turnLeft()
  rootNode.left = turtle.inspect()

  turtle.turnLeft()
  rootNode.back = turtle.inspect()

  turtle.turnLeft()
  rootNode.right = turtle.inspect()

  turtle.turnLeft()

  turtle.forward()

  print(rootNode.left)
  print('and')
  print(rootNode)
end

function main()
  slam = Slam:new()

  return slam:scan()
end

main()
