local wezterm = require("wezterm")

local fontFamily = "JetBrains Mono"
local fontWeight = "Medium"

return {
  font = wezterm.font_with_fallback({
    {
      family = fontFamily,
      weight = fontWeight,
    },
    {
      family = "Symbols Nerd Font Mono",
      scale = 0.7,
    },
  }),
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
  font_size = 15.0,
  --
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  window_padding = {
    top = 0,
    right = 0,
    bottom = 0,
    left = 0,
  },
  -- force_reverse_video_cursor = true,
  color_scheme = "kanagawa",
  window_decorations = "RESIZE",
  default_cursor_style = "SteadyBar",
}
