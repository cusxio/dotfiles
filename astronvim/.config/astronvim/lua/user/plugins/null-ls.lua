local null_ls = require("null-ls")
local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  sources = {
    b.code_actions.eslint_d,
    b.diagnostics.eslint_d,
    b.formatting.eslint_d,

    b.code_actions.gitsigns,

    b.formatting.gofmt,

    b.formatting.prettier.with({
      extra_filetypes = { "astro" },
    }),

    b.formatting.stylua,

    b.code_actions.shellcheck,
    b.diagnostics.shellcheck,

    b.formatting.shfmt,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync(nil, 10000)
        end,
      })
    end
  end,
}
