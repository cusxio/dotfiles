local M = {
  colorscheme = "kanagawa",
  header = {
    "39 2C 39",
  },
  options = {
    opt = {
      relativenumber = false,
      scrolloff = 15,
      colorcolumn = "80",
      -- list = true,
      -- listchars = {
      --   eol = "↲",
      --   trail = "·",
      --   tab = "» ",
      --   nbsp = "␣",
      --   extends= "<",
      --   precedes = ">",
      --   conceal= "┊",
      --
      -- },
    },
  },
  polish = function()
    vim.filetype.add({
      extension = {
        astro = "astro",
        conf = "config",
      },
    })
  end,
}

return M
