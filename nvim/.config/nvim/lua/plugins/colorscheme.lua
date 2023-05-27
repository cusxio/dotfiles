return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local wave_colors = require("kanagawa.colors").setup({ theme = "wave" })
      local palette = wave_colors.palette

      require("kanagawa").setup({
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
        overrides = function()
          -- local theme = colors.theme
          return {
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
