-- LoveProfiler console driver implementation.

local console = {}

console.print = function(t, i)
  -- Color not yet implemented. Maybe it is need to use dependency lcurses.
  io.write(t._out[i].msg)
end

console.flush = function(t)
  t._out = {}
  -- clear the terminal ANSI sequence. Should work on Windows if ANSY.SYS
  -- is still supported on Windows.
  io.write("\027[H\027[2J")
end

return console

