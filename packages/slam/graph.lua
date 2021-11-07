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
  visitor:visitGraph(self)
end

function Graph:init(x, y, z)
  self.root = Node:new({ position = {x = x, y = y, z = z} })
end

function Graph:serialize()
  return '{ "root": ' .. ((self.root and self.root:serialize()) or 'null') .. ' }'
end

return Graph
