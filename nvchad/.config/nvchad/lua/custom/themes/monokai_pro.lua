local M = {}

M.base_30 = {
  white = "#f7f1ff",
  darker_black = "#131313",
  black = "#222222",
  black2 = "#313131",

  one_bg = "#3c3c3c",
  one_bg2 = "#525252",
  one_bg3 = "#646464",

  grey = "#888888",
  grey_fg = "#a2a2a2",
  grey_fg2 = "#bbbbbb",
  light_grey = "#cfcfcf",

  red = "#fc618d",
  baby_pink = "#ff85b1",
  pink = "#ff739f",

  line = "#484848",

  green = "#7bd88f",
  vibrant_green = "#85e299",

  nord_blue = "#27a1b3",
  blue = "#5ad4e6",

  yellow = "#fce566",
  sun = "#fff97a",

  purple = "#948ae3",
  dark_purple = "#6157b0",

  teal = "#5ad4e6",
  orange = "#fd9353",
  cyan = "#5ad4e6",

  statusline_bg = "#2c2c2c",
  lightbg = "#4d4d4d",
  lightbg2 = "#3e3e3e",
  pmenu_bg = "#7bd88f",
  folder_bg = "#5ad4e6",
}

M.base_16 = {
  base00 = "#222222",
  base01 = "#191919",
  base02 = "#131313",
  base03 = "#363537",
  base04 = "#525053",
  base05 = "#69676c",
  base06 = "#8b888f",
  base07 = "#bab6c0",
  base08 = "#fd9353",
  base09 = "#948ae3",
  base0A = "#5ad4e6",
  base0B = "#fce566",
  base0C = "#5ad4e6",
  base0D = "#7bd88f",
  base0E = "#fc618d",
  base0F = "#fc618d",
}

M.polish_hl = {
  ["@variable"] = {
    fg = M.base_30.white,
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "monokai_pro")

return M

-- dark2 = "#131313",
-- dark1 = "#191919",
-- background = "#222222",
-- text = "#f7f1ff"
-- accent1 = "#fc618d",
-- accent2 = "#fd9353",
-- accent3 = "#fce566",
-- accent4 = "#7bd88f",
-- accent5 = "#5ad4e6",
-- accent6 = "#948ae3",
-- dimmed1 = "#bab6c0",
-- dimmed2 = "#8b888f",
-- dimmed3 = "#69676c",
-- dimmed4 = "#525053",
-- dimmed5 = "#363537",
