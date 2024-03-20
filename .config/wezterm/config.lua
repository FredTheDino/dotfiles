-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()


-- local scheme = wezterm.get_builtin_color_schemes()['Everforest Dark (Gogh)']
local scheme = wezterm.get_builtin_color_schemes()['Bamboo']
-- scheme.background  = '#372725'
-- config.color_schemes = { ["mine"] = scheme }
config.color_scheme = "Bamboo"

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.use_fancy_tab_bar = false
-- config.colors = {
--   tab_bar = {
--     background = scheme["background"],
-- 
--     active_tab = {
--       bg_color = scheme["bg_color"],
--       fg_color = scheme["fg_color"],
--       intensity = 'Normal',
--       underline = 'None',
--       italic = false,
--       strikethrough = false,
--     },
-- 
--     inactive_tab = {
--       bg_color = scheme["ansi"][1],
--       fg_color = scheme["fg_color"],
--     },
-- 
--     inactive_tab_hover = {
--       bg_color = schemes["bg_color"],
--       fg_color = scheme["brights"][8],
--       italic = true,
--     },
-- 
--     new_tab = {
--       bg_color = schemes["bg_color"],,
--       fg_color = '#e0dbb7',
--     },
-- 
--     new_tab_hover = {
--       bg_color = '#6b4e32',
--       fg_color = '#e0dbb7',
--       italic = true,
--     },
--   },
-- }

config.font = wezterm.font('Lilex', {})
config.font_size = 10.0
config.audible_bell = "Disabled"
config.bold_brightens_ansi_colors = "BrightAndBold"

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
