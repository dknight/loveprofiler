# LoveProfiler

LoveProfiler is an extremely simple logger and profiler for [Löve2D](https://love2d.org) framework. It displays useful information about current state of a running game. Also has possibility to log events with three levels: information, warnings and errors. The output of the profiler is displayed on the Löve2D canvas or in console (terminal).
![LoveProfiler Screenshot](/screenshots/screenshot-01.png?raw=true)

## Installation

Installation is very easy. Just use git clone or copy directory `loveprofiler` into your game's directory where file `main.lua` is.

```
love2dproject/
  loveprofiler/
  main.lua
```

## Usage

The most basic usage, create an instance on `love.load()` then call start() method inside `love.draw()`. 

```lua
local LoveProfiler = require("loveprofiler.loveprofiler")

function love.load()
  profiler = LoveProfiler:new() 
end

function love.draw()
  profiler:start()
end

```

## Configuration

You can find all possible configuration options with detailed description in `defaults.lua` file. You can override any option when you create a new instance.

```lua
local LoveProfiler = require("loveprofiler.loveprofiler")

function love.load()
  profiler = LoveProfiler:new{config = {
    driver = "console",
    font_size = 17,
    draw_x = 400,
    color = {0, 0, 1, 1}
  }}
end

function love.draw()
  profiler:start()
end
```

## Drivers

At the moment only 2 drivers are supported: canvas and console. If driver is set to **canvas** then information is display directly on the Löve2D canvas. If **console** then output will be displayed in console (system terminal). See `defaults.lua` file for more details.

## Logging

There are 3 levels of messages: information, warning and error. You can add log entry like this:

```
local LoveProfiler = require("loveprofiler.loveprofiler")

function love.load()
  profiler = LoveProfiler:new()
  profiler:addMessage("Your information message", LoveProfiler.LOG_INFO)
  profiler:addMessage("Your warning message", LoveProfiler.LOG_WARN)
  profiler:addMessage("Your error message", LoveProfiler.LOG_ERROR)
end
```
By default logs are also saved in file `loveprofiler.log`. You can change logging destination by changing configuration property `log_path = "your_path_to_log_file"`, see `defaults.lua`. Also if you set `log_path = nil`, output won't be saved into file at all.

### Disabling logging

To completely disable logging set configuration property `log_enabled = false`.

## Using multiple profilers

You can create as many LoveProfiler instances as you want with different configuration.

```lua
local LoveProfiler = require("loveprofiler.loveprofiler")

function love.load()
  profiler1 = LoveProfiler:new()
  profiler2 = LoveProfiler:new{config = {
  	driver = "console",
    font_size = 18,
    draw_x = 400,
  }}
end

function love.draw()
  profiler1:start()
  profiler2:start()
end

```


## Contribution

Found a bug or implemented new feature? Do not hesitate to make a pull request. 

## License
This software is distributed under [MIT license](https://opensource.org/licenses/MIT), so you are free to use it.
