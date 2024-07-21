---@type LazySpec
return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    style = "night",
    on_highlights = function(hl, c)
      hl.NeoTreeGitUnstaged = {
        fg = c.red,
      }
    end,
  },
}
