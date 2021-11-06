function startsWith(str, start)
  return str:sub(1, #start) == start
end

function endsWith(str, ends)
  return str:sub(-#ends) == ends
end
