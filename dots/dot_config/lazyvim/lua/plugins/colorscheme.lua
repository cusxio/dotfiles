---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monoglow-z",
    },
  },
  -- "folke/tokyonight.nvim",
  -- lazy = true,
  -- opts = {
  --   style = "night",
  --   on_highlights = function(hl, c)
  --     hl.NeoTreeGitUnstaged = {
  --       fg = c.red,
  --     }
  --   end,
  -- },
  {
    "wnkz/monoglow.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.IndentBlanklineChar = { fg = c.syntax.comment, nocombine = true }
        hl.IndentBlanklineContextChar = { fg = c.fg, nocombine = true }
        hl.IblIndent = { fg = c.syntax.comment, nocombine = true }
        hl.IblScope = { fg = c.fg, nocombine = true }
      end,
      on_colors = function(colors)
        colors.git.add = "#a6e22e"
        colors.git.change = "#e6db74"
        colors.git.delete = "#f92672"

        colors.error = "#f92672"
        colors.warning = "#fd971f"
        colors.info = "#66d9ef"
        colors.hint = "#66d9ef"
      end,
    },
  },
}
