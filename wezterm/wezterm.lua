local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'AdventureTime'
config.window_decorations = 'TITLE'

return config
