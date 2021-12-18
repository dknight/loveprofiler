-- LoveProfiler console driver implementation.

local canvas = {}

canvas.print = function(t, i)
  love.graphics.setColor(table.unpack(t._out[i].color))
  love.graphics.print(
    t._out[i].msg,
    t.config.draw_x,
    t.config.draw_y + (i - 1) * t.config.font_size
  )
end

canvas.flush = function(t)
  t._out = {}
  love.graphics.reset()
end

return canvas

