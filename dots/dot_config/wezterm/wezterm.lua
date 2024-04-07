local wezterm = require("wezterm")

local fontFamily = "JetBrains Mono"
local fontWeight = "Medium"

return {
  -- color_scheme = "Kanagawa (Gogh)",
  color_scheme = "Material Darker (base16)",
  -- color_scheme = "Monokai Pro (Spectrum)",
  default_cwd = wezterm.home_dir .. "/Documents/dev",
  default_prog = {
    "/opt/homebrew/bin/fish",
    "-l",
  },
  font_size = 15,
  font_rules = {
    {
      -- italic
      intensity = "Normal",
      italic = true,
      font = wezterm.font({
        family = fontFamily,
        weight = fontWeight,
        italic = false,
      }),
    },
    {
      -- bold
      intensity = "Bold",
      italic = false,
      font = wezterm.font({
        family = fontFamily,
        weight = fontWeight,
      }),
    },
    {
      -- italic bold
      intensity = "Bold",
      italic = true,
      font = wezterm.font({
        family = fontFamily,
        weight = fontWeight,
        italic = false,
      }),
    },
  },
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_padding = {
    top = 0,
    right = 0,
    bottom = 0,
    left = 0,
  },
  window_decorations = "RESIZE",
  audible_bell = "Disabled",
}
