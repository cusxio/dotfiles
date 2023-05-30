return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local wave_colors = require("kanagawa.colors").setup({ theme = "wave" })
      local palette = wave_colors.palette

      require("kanagawa").setup({
        compile = false,
        theme = "wave",
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
            MsgArea = { link = "Normal" },

            Winbar = {
              bg = theme_colors.ui.bg,
              fg = theme_colors.ui.fg_dim,
            },
            WinbarNC = { link = "StatusLine" },

            IndentBlanklineContextChar = { fg = "#43434c" },
            IndentBlanklineContextStart = {
              link = "CursorLine",
              underline = false,
            },
          }
        end,
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
