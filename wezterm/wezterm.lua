-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; with-ignout even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

--config.color_scheme = 'AdventureTime'
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
--config.integrated_title_button_style = 'Gnome'

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false

config.window_padding =
{
    left = '0.25cell',
    right = '0.25cell',
    top = '0.25cell',
    bottom = '1.3cell',
}

config.adjust_window_size_when_changing_font_size = false
config.use_resize_increments = true

config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

return config
