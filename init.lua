-- LoveProfiler for Love2D Framework
-- Author: Dmitri Smirnov <http://www.whoop.ee>
-- MIT License
-- VERSION: 1.0.1
local defaults = require("loveprofiler.defaults")

---@alias level
---| '"INFO"'
---| '"WARNING"'
---| '"ERROR"'

---@class LoveProfiler
---@field public config table
---@field private _out table
---@field private _log table
---@field private _driver table
local LoveProfiler = {
	LOG_INFO = "INFO", ---[[@as level]]
	LOG_WARN = "WARNING", ---[[@as level]]
	LOG_ERROR = "ERROR", ---[[@as level]]
}

---Creates new instance aka constructor
---@param t? table - Config can be passed here.
---@return table - New instance of LoveProfiler.
function LoveProfiler:new(t)
	t = t or {}

	t._out = {}
	t._log = {}

	-- Merge configs.
	local cfg = {}
	for k, v in pairs(defaults) do
		cfg[k] = v
	end
	if t.config then
		for k, v in pairs(t.config) do
			cfg[k] = v
		end
	end
	t.config = cfg

	---@private
	t._driver = require("loveprofiler.drivers." .. t.config.driver)

	setmetatable(t, self)
	self.__index = self
	return t
end

---Adds message to log.
---@param msg string - Message to be logged.
---@param level? level level Level of the logged
function LoveProfiler:addMessage(msg, level)
	level = level or LoveProfiler.LOG_INFO
	self._log[#self._log + 1] = {
		["msg"] = msg,
		["level"] = level,
	}
	if self.config.log_path then
		local time = os.date(self.config.log_date_format)
		local file = io.open(self.config.log_path, "a")
		if file ~= nil then
			file:write(string.format("%s %s %s\n", time, level, msg))
			file:close()
		end
	end
end

--- Processed the log if log is enabled.
function LoveProfiler:processLog()
	local start = #self._log > self.config.log_size
			and #self._log - self.config.log_size
		or 1
	local stop = #self._log
	for i = start, stop do
		local color
		if self._log[i].level == LoveProfiler.LOG_WARN then
			color = self.config.log_color_warn
		elseif self._log[i].level == LoveProfiler.LOG_ERROR then
			color = self.config.log_color_error
		else
			color = self.config.log_color_info
		end

		self:appendToOutput(self._log[i].msg, color)
	end
end

---Adds line to output.
---@param msg string Message (line) to be added.
---@param color? table Color as table {r, g, b, a}.
function LoveProfiler:appendToOutput(msg, color)
	color = color or self.config.color
	self._out[#self._out + 1] = {
		["msg"] = msg .. "\n",
		["color"] = color,
	}
end

---Gets the name of OS.
---@return string
function LoveProfiler:getOS()
	return love.system.getOS()
end

---Gets FPS count.
---@return number
function LoveProfiler:getFPS()
	return love.timer.getFPS()
end

---Gets mouse coordinates.
---@return number, number
function LoveProfiler:mouse()
	return love.mouse.getX(), love.mouse.getY()
end

---Gets the time between 2 frames in milliseconds.
---@return number
function LoveProfiler:getDelta()
	return love.timer.getDelta() * 1000
end

---Gets the memory usage in bytes, textures + Lua + Love2d program.
---@return number
function LoveProfiler:getMemoryUsage()
	local stats = love.graphics.getStats()
	return math.floor(collectgarbage("count") + stats.texturememory + 0.5)
end

---Gets time duration
---@return number
function LoveProfiler:getDuration()
	return love.timer.getTime()
end

---@return string
---Formats duration
function LoveProfiler:formatDuration()
	local f = "Duration: %02d:%02d:%02d.%03d"
	local t = LoveProfiler:getDuration()
	local h = t % (24 * 3600) / 3600

	t = t % 3600
	local m = t / 60

	t = t % 60
	local s = t

	local ms = (s - math.floor(s)) * 1000

	return string.format(f, h, m, s, ms)
end

---Starts the profiler, should be used in love.draw() method.
function LoveProfiler:start()
	local font = love.graphics.newFont(self.config.font_size)
	love.graphics.setFont(font)

	if self.config.show_os then
		self:appendToOutput(string.format("OS: %s", self:getOS()))
	end

	if self.config.show_fps then
		self:appendToOutput(string.format("FPS: %s", self:getFPS()))
	end

	if self.config.show_mem then
		self:appendToOutput(
			string.format("MEM: %s bytes", self:getMemoryUsage())
		)
	end

	if self.config.show_coords and self.config.driver == "canvas" then
		love.graphics.setColor(self.config.color)
		local x, y = self:mouse()
		local coords = string.format("%d, %d", x, y)
		x = x + self.config.x_coords_offset
		y = y + self.config.y_coords_offset
		love.graphics.print(coords, x, y)
		love.graphics.reset()
	end

	if self.config.show_delta then
		self:appendToOutput(string.format("Delta: %.1fms", self:getDelta()))
	end

	if self.config.show_duration then
		self:appendToOutput(LoveProfiler:formatDuration())
	end

	if self.config.log_enabled then
		if #self._log > 0 then
			self:appendToOutput("---------- Log ----------")
		end
		self:processLog()
	end

	for i = 1, #self._out do
		self._driver.print(self, i)
	end

	self._driver.flush(self)
end

return LoveProfiler
