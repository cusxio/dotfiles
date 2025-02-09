---@type LazySpec
-- return {
--   "nvim-lualine/lualine.nvim",
--   opts = function(_, opts)
--     local icons = LazyVim.config.icons
--     -- local colors = require("tokyonight.colors").setup({
--     --   style = "night",
--     --   ---@type fun(colors: ColorScheme)
--     --   on_colors = function(c)
--     --     c.bg = "#121212"
--     --     c.bg_sidebar = "#121212"
--     --   end,
--     --   ---@type fun(hl: tokyonight.Highlights, c: ColorScheme)
--     --   on_highlights = function(hl, c)
--     --     hl.NeoTreeGitUnstaged = { fg = c.red }
--     --   end,
--     -- })
--
--     opts.options = {
--       theme = "auto",
--       component_separators = "/",
--       section_separators = "",
--     }
--
--     opts.sections.lualine_a = {
--       {
--         "mode",
--         icon = "",
--         separator = { right = "" },
--       },
--     }
--
--     opts.sections.lualine_b = { { "branch", icon = "" } }
--
--     opts.sections.lualine_c = {
--       {
--         "diagnostics",
--         symbols = {
--           error = icons.diagnostics.Error,
--           warn = icons.diagnostics.Warn,
--           info = icons.diagnostics.Info,
--           hint = icons.diagnostics.Hint,
--         },
--       },
--       { LazyVim.lualine.pretty_path() },
--     }
--
--     opts.sections.lualine_y = {
--       {
--         "progress",
--       },
--     }
--
--     opts.sections.lualine_z = {
--       {
--         "location",
--         separator = { left = "" },
--       },
--     }
--
--     return opts
--   end,
-- }

return {

  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = {
      component_separators = "/",
      section_separators = "",
    }

    opts.sections.lualine_y = {
      { "progress" },
    }

    opts.sections.lualine_z = {
      { "location" },
    }

    return opts
  end,
  -- "nvim-lualine/lualine.nvim",
  -- opts = function(_, opts)
  --   local icons = LazyVim.config.icons
  --   local colors = require("tokyonight.colors").setup({
  --     style = "night",
  --   })
  --
  --   local bg = colors.bg_dark
  --   local fg = colors.dark3
  --
  --   opts.options = {
  --     theme = {
  --       normal = {
  --         a = { bg = bg, fg = fg },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       insert = {
  --         a = { bg = bg, fg = colors.green },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       visual = {
  --         a = { bg = bg, fg = colors.magenta },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       replace = {
  --         a = { bg = bg, fg = colors.red },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       command = {
  --         a = { bg = bg, fg = colors.yellow },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       inactive = {
  --         a = { bg = bg, fg = fg },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --       terminal = {
  --         a = { bg = bg, fg = colors.green1 },
  --         b = { bg = bg, fg = fg },
  --         c = { bg = bg, fg = fg },
  --       },
  --     },
  --     component_separators = { left = "", right = "" },
  --     section_separators = { left = "", right = "" },
  --   }
  --
  --   opts.sections.lualine_b = { { "branch", icon = "" } }
  --
  --   opts.sections.lualine_c = {
  --     {
  --       "diagnostics",
  --       symbols = {
  --         error = icons.diagnostics.Error,
  --         warn = icons.diagnostics.Warn,
  --         info = icons.diagnostics.Info,
  --         hint = icons.diagnostics.Hint,
  --       },
  --     },
  --     { LazyVim.lualine.pretty_path() },
  --   }
  --
  --   opts.sections.lualine_z = {}
  --
  --   return opts
  -- end,
}
