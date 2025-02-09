---@type LazySpec
return {
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "monoglow-z",
  --   },
  -- },
  {
    "folke/tokyonight.nvim",
    ---@module "tokyonight"
    ---@type tokyonight.Config
    opts = {
      style = "night",
      on_colors = function(colors)
        colors.git.add = "#a6e22e"
        colors.git.change = "#ffd700"
        colors.git.delete = "#f92672"
      end,
      on_highlights = function(highlights, colors)
        local Util = require("tokyonight.util")
        highlights["CursorLine"] = { bg = Util.lighten(colors.bg, 0.95) }
      end,
    },
  },
  -- {
  --   "wnkz/monoglow.nvim",
  --   lazy = true,
  --   ---@module "monoglow"
  --   ---@type monoglow.Config
  --   opts = {
  --     glow = false,
  --     on_colors = function(colors)
  --       colors.git.add = "#a6e22e"
  --       colors.git.change = "#e6db74"
  --       colors.git.delete = "#f92672"
  --
  --       colors.error = "#f92672"
  --       colors.warning = "#fd971f"
  --       colors.info = "#66d9ef"
  --       colors.hint = "#66d9ef"
  --     end,
  --     on_highlights = function(hl, c)
  --       local util = require("monoglow.util")
  --
  --       -- local glow_yellow = "#ffd700"
  --       -- local glow_red = "#fd1b7c"
  --       -- local glow_red = "#ff4500"
  --
  --       local glow_light_1 = util.lighten(c.glow, 0.5)
  --
  --       hl["@keyword.return"] = { fg = c.glow }
  --       hl["@keyword.exception"] = { fg = c.glow }
  --
  --       hl["@number.tsx"] = { fg = glow_light_1 }
  --       hl["@number.typescript"] = { fg = glow_light_1 }
  --
  --       hl["@boolean.tsx"] = { fg = glow_light_1 }
  --       hl["@boolean.typescript"] = { fg = glow_light_1 }
  --
  --       hl["@tag.tsx"] = { link = "@tag.builtin.tsx" }
  --       hl["@tag.attribute.tsx"] = { fg = util.lighten(c.glow, 0.2) }
  --
  --       hl["SnacksIndent"] = { fg = c.gray3 }
  --       hl["SnacksIndentScope"] = { fg = c.glow }
  --
  --       -- fzf-lua
  --       hl["FzfLuaBorder"] = { fg = c.border }
  --       hl["FzfLuaFzfBorder"] = { link = "FzfLuaBorder" }
  --       hl["FzfLuaFzfScrollbar"] = { link = "FzfLuaBorder" }
  --       hl["FzfLuaFzfSeparator"] = { link = "FzfLuaBorder" }
  --
  --       hl["FzfLuaTitle"] = { fg = c.gray9 }
  --       hl["FzfLuaHeader"] = { link = "FzfLuaTitle" }
  --       hl["FzfLuaHeaderText"] = { fg = c.gray5 }
  --       hl["FzfLuaHeaderBind"] = { fg = c.glow }
  --
  --       hl["FzfLuaFzfPointer"] = { fg = c.glow }
  --       hl["FzfLuaFzfMarker"] = { link = "FzfLuaFzfPointer" }
  --       hl["FzfLuaFzfSpinner"] = { link = "FzfLuaFzfPointer" }
  --
  --       hl["FzfLuaFzfPrompt"] = { fg = c.glow }
  --       hl["FzfLuaFzfMatch"] = { fg = c.glow }
  --
  --       hl["FzfLuaDirPart"] = { fg = c.gray7 }
  --       hl["FzfLuaFilePart"] = { link = "FzfLuaDirPart" }
  --     end,
  --   },
  -- },
}
