local augroup = vim.api.nvim_create_augroup("format_on_save", {})

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("null-ls").setup({
            debug = true,
            on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({
                      bufnr,
                      timeout_ms = 5000,
                    })
                  end,
                })
              end
            end,
          })
        end,
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          {
            "jay-babu/mason-null-ls.nvim",
            cmd = { "NullLsInstall", "NullLsUninstall" },
            opts = {
              ensure_installed = {
                "prettierd",
                "shfmt",
                "stylua",
                "eslint_d",
                "shellcheck",
              },
              handlers = {
                eslint_d = function()
                  local null_ls = require("null-ls")
                  null_ls.register(null_ls.builtins.diagnostics.eslint_d)
                  null_ls.register(null_ls.builtins.formatting.eslint_d)
                  null_ls.register(null_ls.builtins.code_actions.eslint_d)
                end,
                prettierd = function()
                  local null_ls = require("null-ls")
                  null_ls.register(null_ls.builtins.formatting.prettierd.with({
                    extra_filetypes = { "astro" },
                  }))
                end,
              },
            },
          },
        },
      },
      -- {
      --   "j-hui/fidget.nvim",
      --   opts = {
      --     text = {
      --       spinner = "dots",
      --     },
      --   },
      -- },
    },
    config = function()
      require("setup.lsp")
    end,
  },
}
