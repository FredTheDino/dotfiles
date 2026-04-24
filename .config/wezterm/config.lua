-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()


-- local scheme = wezterm.get_builtin_color_schemes()['Everforest Dark (Gogh)']
-- local scheme = wezterm.get_builtin_color_schemes()['Django']
-- scheme.background  = '#372725'
-- config.color_schemes = { ["mine"] = scheme }
-- config.color_scheme = 'Belafonte Night (Gogh)'
-- config.color_scheme = 'Everforest Dark (Gogh)'
--
local scheme = wezterm.get_builtin_color_schemes()['GruvboxDarkHard']
scheme.background  = '#11121b'
config.color_schemes = { ["mine"] = scheme }
config.color_scheme = "mine"

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.use_fancy_tab_bar = false

config.font = wezterm.font('FantasqueSansM Nerd Font', {})
-- config.font = wezterm.font('FantasqueSansM Nerd Font', {})
-- config.font = wezterm.font('VictorMono Nerd Font', {})
config.font_size = 13.0
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"

-- config.window_background_opacity = 0.8

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
