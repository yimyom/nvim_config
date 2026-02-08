local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

--config.color_scheme = 'AdventureTime'
config.window_decorations = 'RESIZE'

config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.window_padding =
{
    left = '0.25cell',
    right = '0.25cell',
    top = '0.25cell',
    --bottom = '0.5cell',
    bottom = '1cell',
}

config.adjust_window_size_when_changing_font_size = false
config.use_resize_increments = true

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
