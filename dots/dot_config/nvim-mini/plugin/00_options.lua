vim.o.cmdheight = 0
vim.o.scrolloff = 7

-- Editing
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true

vim.o.clipboard = "unnamedplus"

now(function()
  require("mini.basics").setup({
    autocommands = {
      relnum_in_visual_mode = true,
    },
  })
end)

now(function()
  add("folke/tokyonight.nvim")
  local opts = {
    style = "night",
    on_colors = function(colors)
      colors.git.add = "#a6e22e"
      colors.git.change = "#ffd700"
      colors.git.delete = "#f92672"
    end,
    on_highlights = function(highlights, colors)
      highlights["StatusLine"] = { bg = colors.bg, fg = colors.fg }
    end,
  }
  require("tokyonight").setup(opts)

  _G.colors = require("tokyonight.colors").setup(opts)

  vim.cmd("colorscheme tokyonight")
end)
