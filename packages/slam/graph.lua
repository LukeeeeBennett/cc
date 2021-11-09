local Node = require('node')

Graph = { root = false }

function Graph:new(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  self.type = 'Graph'

  return o
end

function Graph:accept(visitor)
  return visitor:visitGraph(self)
end

function Graph:init(root)
  self.root = root
end

return Graph
