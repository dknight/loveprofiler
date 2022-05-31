--
-- Defaults of the LoveProfiler configuration.
--
local defaults = {
  ----------------------------------------------
  -- Drivers                                  --
  ----------------------------------------------
  -- Implemented drivers:
  -- "canvas" outputs on the canvas inside Love2D application;
  -- "console" outputs in the console (terminal).
  driver = "canvas",

  ----------------------------------------------
  -- Drawing options (only for canvas driver) --
  ----------------------------------------------
  -- Default out put color (R, G, B, A).
  color = {0, 1, 0, 1},

  -- Font size of output.
  font_size = 14,

  -- x position of the output.
  draw_x = 5,

  -- y position of the output.
  draw_y = 5,

  ----------------------------------------------
  -- Enabled these options in output          --
  ----------------------------------------------
  -- Display the name of the operating system.
  show_os = true,

  -- Display FPS (Frames Per Second)
  show_fps = true,

  -- Display memory usage.
  show_mem = true,

  -- Shows the time between 2 frames.
  show_delta = true,

  -- Shows the duration of programm running
  show_duration = true,

  -- Show mouse coordindates.
  show_coords = false,

  -- Coordindates offest, only for canvas driver.
  x_coords_offset = 10,
  y_coords_offset = -10,

  -- TODO: implement more
  
  ----------------------------------------------
  -- Log options                              --
  ----------------------------------------------
  -- Enables of disables log completely.
  log_enabled = true,

  -- How many last messages will be displayed.
  log_size = 10,

  -- Logs output into file, use nil or false to disable file logging.
  log_path = "loveprofiler.log",

  -- Date format in the logs.
  log_date_format = "%Y-%m-%dT%H:%M:%S",

  -- Log info level color (R, G, B, A).
  log_color_info = {1, 1, 1, 1},

  -- Log warning level color (R, G, B, A).
  log_color_warn = {1, 1, 0, 1},

  -- Log error level color (R, G, B, A).
  log_color_error = {1, 0, 0, 1}
}

return defaults
