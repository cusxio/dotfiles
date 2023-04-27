return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "astro",
        "bashls",
        "cssls",
        -- "denols",
        "emmet_ls",
        -- "gopls",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        -- "sqls",
        "solidity",
        "svelte",
        "tailwindcss",
        "tsserver",
        "yamlls",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "shfmt",
        "stylua",
        "eslint_d",
        "shellcheck",
      },
      handlers = {
        prettierd = function()
          local null_ls = require("null-ls")
          null_ls.register(null_ls.builtins.formatting.prettierd.with({ extra_filetypes = { "astro" } }))
        end,
      },
    },
  },
}
