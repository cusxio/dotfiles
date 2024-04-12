---@type LazySpec
-- return {
--   "AstroNvim/astroui",
--   opts = function(_, opts)
--     local colors = require("material.colors")
--     return require("astrocore").extend_tbl(opts, {
--       colorscheme = "material",
--       -- status = {
--       --   colors = {
--       --     normal = colors.main.blue,
--       --   },
--       -- },
--     })
--   end,
-- }

return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "material",
    highlights = {
      material = function()
        local colors = require("material.colors")
        return {
          HeirlineNormal = { bg = colors.main.blue },
        }
      end,
    },
  },
}
