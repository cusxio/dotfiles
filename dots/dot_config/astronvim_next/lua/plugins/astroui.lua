---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "tokyonight-night",
    -- colorscheme = "roseprime",
    -- colorscheme = "material",
    -- highlights = {
    --   init = function()
    --     return {
    --       NeoTreeTabActive = { bold = false },
    --     }
    --   end,
    --   material = function()
    --     local colors = require("material.colors")
    --
    --     return {
    --       HeirlineNormal = { bg = colors.main.blue },
    --       HeirlineInsert = { bg = colors.main.green },
    --       HeirlineVisual = { bg = colors.main.yellow },
    --       -- Identifier = { fg = colors.main.white },
    --       -- ["@keyword.import"] = { link = "@conditional" },
    --     }
    --   end,
    -- },
  },
}
