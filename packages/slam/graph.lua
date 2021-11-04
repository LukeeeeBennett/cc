local Node = require('node')
-- local Edge = require('edge')

Graph = { root = false }

function Graph:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Graph:init()
  self.root = Node:new()
end

return Graph
