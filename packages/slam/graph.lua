local Node = require('node')

Graph = { root = false }

function Graph:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Graph:init()
  self.root = Node:new()

  return self.root
end

return Graph
