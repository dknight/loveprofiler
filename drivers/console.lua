-- LoveProfiler console driver implementation.

---Checks that OS is Microsoft Windows.
---@return boolean
local function isWindows()
	return type(package) == "table" and type(package.config) == "string" and package.config:sub(1, 1) == "\\"
end

---Checks that termianl supports colors.
---@return boolean
local function isColorSupported()
	if isWindows() then
		return not not os.getenv("ANSICON")
	end
	return true
end

---@class console
local console = {}

---@param t table
---@param i number
console.print = function(t, i)
	-- Color not yet implemented. Maybe it is need to use dependency lcurses.
	io.write(t._out[i].msg)
end

---@param t table
console.flush = function(t)
	t._out = {}
	-- clear the terminal ANSI sequence. Should work on Windows if ANSI.SYS
	-- is still supported.
	if isColorSupported() then
		io.write("\027[H\027[2J")
	end
end

return console
