return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin",
    opts = {
      no_italic = true,
      no_bold = true,
      integrations = {
        leap = true,
      },
    },
  },
  { import = "astrocommunity.colorscheme.kanagawa" },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "wave",
      colors = {
        theme = {
          wave = {
            ui = {
              bg = "#1B1D26",
            },
          },
        },
      },
    },
  },
  { import = "astrocommunity.colorscheme.tokyonight" },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
    },
  },
  { import = "astrocommunity.colorscheme.nightfox" },
  {
    "EdenEast/nightfox.nvim",
    opts = {},
  },
  { import = "astrocommunity.colorscheme.oxocarbon" },
}
