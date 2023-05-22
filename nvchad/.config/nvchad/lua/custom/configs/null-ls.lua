local null_ls = require("null-ls")
local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("format_on_save", {})

null_ls.setup({
  debug = true,
  sources = {
    require("typescript.extensions.null-ls.code-actions"),

    code_actions.eslint_d,
    diagnostics.eslint_d,
    formatting.eslint_d,

    formatting.prettierd.with({ extra_filetypes = { "astro" } }),

    formatting.stylua,
  },
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
