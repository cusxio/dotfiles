local M = {}

M.treesitter = {
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "lua",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  playground = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    "typescript-language-server",
    "lua-language-server",

    "eslint_d",
    "prettierd",
    "stylua",
  },
}

M.cmp = {
  mapping = {
    ["<C-k>"] = require("cmp").mapping.select_prev_item(),
    ["<C-j>"] = require("cmp").mapping.select_next_item(),
  },
}

return M
