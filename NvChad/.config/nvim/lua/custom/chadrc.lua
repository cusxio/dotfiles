local M = {}

local userPlugins = require("custom.plugins")

M.ui = {
  theme = "radium",
}

M.plugins = {
  remove = {
    "numToStr/Comment.nvim",
  },
  options = {
    statusline = {
      separator_style = "block",
    },
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "bash",
        "css",
        "graphql",
        "go",
        "html",
        "javascript",
        "lua",
        "prisma",
        "tsx",
        "typescript",
        "rust",
        "solidity",
        "vim",
      },
    },
    ["nvim-telescope/telescope.nvim"] = {
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--iglob",
            "!.git",
            "--hidden",
          },
        },
      },
    },
  },
  user = userPlugins,
}

M.mappings = require("custom.mappings")

return M
