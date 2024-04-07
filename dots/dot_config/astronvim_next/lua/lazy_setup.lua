require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    import = "astronvim.plugins",
  },
  { import = "plugins" },
} --[[@as LazySpec]], {
  defaults = { lazy = true },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
