-- local bg = "#1B1D26"

return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- {
  --   "catppuccin",
  --   opts = {
  --     flavour = "mocha",
  --     no_italic = true,
  --     no_bold = true,
  --     integrations = {
  --       leap = true,
  --     },
  -- color_overrides = {
  --   mocha = {
  --     base = bg,
  --     mantle = bg,
  --     crust = bg,
  --   },
  -- },
  -- },
  -- },
  -- { import = "astrocommunity.colorscheme.kanagawa" },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   opts = {
  --     theme = "wave",
  --     colors = {
  --       theme = {
  --         wave = {
  --           ui = {
  --             bg = bg,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- { import = "astrocommunity.colorscheme.tokyonight" },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     style = "moon",
  --   },
  -- },
  -- { import = "astrocommunity.colorscheme.nightfox" },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   opts = {},
  -- },
  -- { import = "astrocommunity.colorscheme.oxocarbon" },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   config = function()
  --     local oxocarbon = require("oxocarbon")
  --     vim.api.nvim_set_hl(0, "NeoTreeNormal", { fg = oxocarbon.base04, bg = oxocarbon.base00 })
  --   end,
  -- },
  { import = "astrocommunity.colorscheme.monokai-pro" },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      filter = "spectrum",
      devicons = false,
    },
  },
}
