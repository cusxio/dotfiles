return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local wave_colors = require("kanagawa.colors").setup({ theme = "wave" })
      local palette = wave_colors.palette

      require("kanagawa").setup({
        compile = true,
        theme = "wave",
        dimInactive = true,
        colors = {
          theme = {
            wave = {
              syn = {
                identifier = palette.waveRed,
                punct = palette.oniViolet,
              },
              ui = {
                bg_gutter = "NONE",
                whitespace = "#31313a",
              },
            },
          },
        },
        overrides = function(colors)
          local palette_colors = colors.palette
          local theme_colors = colors.theme
          return {
            StatusLine = {
              bg = theme_colors.ui.bg,
              fg = palette_colors.fujiGray,
            },
            StatusLineNC = { link = "Normal" },
            Winbar = {
              bg = theme_colors.ui.bg,
              fg = theme_colors.ui.fg_dim,
            },
            WinbarNC = { link = "StatusLine" },
            MsgArea = { link = "Normal" },
            --
            -- IndentBlanklineContextChar = { fg = "#43434c" },
            -- IndentBlanklineContextStart = {
            --   link = "CursorLine",
            --   underline = false,
            -- },
            --
            TelescopeTitle = { fg = theme_colors.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme_colors.ui.bg_p1 },
            TelescopePromptBorder = {
              fg = theme_colors.ui.bg_p1,
              bg = theme_colors.ui.bg_p1,
            },
            TelescopeResultsNormal = {
              fg = theme_colors.ui.fg_dim,
              bg = theme_colors.ui.bg_m1,
            },
            TelescopeResultsBorder = {
              fg = theme_colors.ui.bg_m1,
              bg = theme_colors.ui.bg_m1,
            },
            TelescopePreviewNormal = { bg = theme_colors.ui.bg_dim },
            TelescopePreviewBorder = {
              bg = theme_colors.ui.bg_dim,
              fg = theme_colors.ui.bg_dim,
            },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
