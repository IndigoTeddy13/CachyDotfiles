-- Import and initialize the WezTerm API
local wezterm = require "wezterm"
local config = {}

-- Disable Wayland support to run in Hyprland
config.enable_wayland = false

-- Set font and color scheme
config.font = wezterm.font "Source Code Pro"
config.font_size = 15
config.background = {
    {
        source = {
            Color = "#000000",
        },
        width = "100%",
        height = "100%",
        opacity = 0.85,
      },
}
config.hide_tab_bar_if_only_one_tab = true

-- Bell event handler
wezterm.on("bell", function(window, pane)
	wezterm.log_info("The bell was rung in pane " .. pane:pane_id() .. "!")
end)
config.audible_bell = "SystemBeep"

-- Visual Bell
config.visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 150,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 150,
}
config.colors = {
    visual_bell = "#200000",
}

-- Return the configuration back for WezTerm to use
return config
