---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons
    local colors = require("tokyonight.colors").setup({
      style = "moon",
    })

    local bg = colors.bg_dark
    local fg = colors.dark3

    opts.options = {
      theme = {
        normal = {
          a = { bg = bg, fg = fg },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        insert = {
          a = { bg = bg, fg = colors.green },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        visual = {
          a = { bg = bg, fg = colors.magenta },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        replace = {
          a = { bg = bg, fg = colors.red },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        command = {
          a = { bg = bg, fg = colors.yellow },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        inactive = {
          a = { bg = bg, fg = fg },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
        temrinal = {
          a = { bg = bg, fg = colors.green1 },
          b = { bg = bg, fg = fg },
          c = { bg = bg, fg = fg },
        },
      },
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    }

    opts.sections.lualine_b = { { "branch", icon = "" } }

    opts.sections.lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
          hint = icons.diagnostics.Hint,
        },
      },
      { LazyVim.lualine.pretty_path() },
    }

    opts.sections.lualine_z = {}

    return opts
  end,
}
