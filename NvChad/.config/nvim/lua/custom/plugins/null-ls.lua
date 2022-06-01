local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

-- local command_resolver = require("null-ls.helpers.command_resolver")

local M = {}

local b = null_ls.builtins

local sources = {
  b.code_actions.eslint_d,
  b.diagnostics.eslint_d,
  b.formatting.eslint_d,

  b.formatting.prettier,

  b.formatting.stylua,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.setup = function()
  null_ls.setup({
    debug = true,

    sources = sources,

    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.formatting_sync()
          end,
        })
      end
    end,
  })
end

return M
