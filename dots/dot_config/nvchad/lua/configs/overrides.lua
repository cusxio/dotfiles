-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",

    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",

    "astro",
  },
  matchup = {
    enable = true,
  },
  autotag = {
    enable = true,
    -- https://github.com/windwp/nvim-ts-autotag/issues/125
    enable_close_on_slash = false,
  },
}

M.indent = {
  scope = {
    show_start = false,
    show_end = false,
  },
}

return M
