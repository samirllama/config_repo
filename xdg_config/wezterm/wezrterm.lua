local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- apply config choices

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- config.font = wezterm.font("Dank Mono", {
--      weight = "Regular",
--      italic = false,
--      stretch = "Normal",
--})
config.enable_tab_bar = false
config.font_size = 16.0

-- config.window_background_image_hsb = {
--      brightness = 0.01,
--      hue = 1.0,
--      saturation = 0.5,
-- }

-- config.window_background_opacity = 0.92
-- config.window_background_opacity = 1.0
-- config.window_background_opacity = 0.78
config.window_background_opacity = 0.50

-- config.macos_window_background_blur = 1
config.macos_window_background_blur = 82
-- config.macos_window_background_blur = 60

config.window_background_image = "/Users/apex/Downloads/5_artsy_samu.jpg"
-- config.window_background_image = "/Users/apex/Downloads/snail.gif"

config.window_decorations = "RESIZE"
config.keys = {
	{
		key = "f",
		mods = "CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
