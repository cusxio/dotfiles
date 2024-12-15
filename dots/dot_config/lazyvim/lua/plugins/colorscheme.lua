---@type LazySpec
return {
  -- "folke/tokyonight.nvim",
  -- opts = {
  --   style = "night",
  --   ---@type fun(colors: ColorScheme)
  --   on_colors = function(c)
  --     c.bg = "#121212"
  --     c.bg_sidebar = "#121212"
  --   end,
  --   ---@type fun(hl: tokyonight.Highlights, c: ColorScheme)
  --   on_highlights = function(hl, c)
  --     hl.NeoTreeGitUnstaged = { fg = c.red }
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monoglow-z",
    },
  },
  {
    "wnkz/monoglow.nvim",
    lazy = true,
    ---@module "monoglow"
    ---@type monoglow.Config
    opts = {
      glow = false,
      on_highlights = function(hl, c)
        local util = require("monoglow.util")

        -- local glow_yellow = "#ffd700"
        -- local glow_red = "#fd1b7c"
        -- local glow_red = "#ff4500"

        local glow_light_1 = util.lighten(c.glow, 0.5)

        hl["@keyword.return"] = { fg = c.glow, nocombine = true }
        hl["@keyword.exception"] = { fg = c.glow, nocombine = true }
        -- hl["@keyword.import.tsx"] = { fg = c.glow, nocombine = true }
        -- hl["@keyword.import.typescript"] = { fg = c.glow, nocombine = true }
        -- hl["@keyword.tsx"] = { fg = c.glow, nocombine = true }
        -- hl["@keyword.typescript"] = { fg = c.glow, nocombine = true }
        -- hl["@keyword"] = { fg = util.lighten(c.glow, 0.8), nocombine = true }
        --

        hl["@number.tsx"] = { fg = glow_light_1, nocombine = true }
        hl["@number.typescript"] = { fg = glow_light_1, nocombine = true }

        hl["@boolean.tsx"] = { fg = glow_light_1, nocombine = true }
        hl["@boolean.typescript"] = { fg = glow_light_1, nocombine = true }

        hl["@tag.tsx"] = { link = "@tag.builtin.tsx", nocombine = true }
        hl["@tag.attribute.tsx"] =
          { fg = util.lighten(c.glow, 0.2), nocombine = true }

        hl["SnacksIndent"] = { fg = c.gray3, nocombine = true }
        hl["SnacksIndentScope"] = { fg = c.glow, nocombine = true }
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
