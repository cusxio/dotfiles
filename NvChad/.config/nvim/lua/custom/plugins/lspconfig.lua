vim.diagnostic.config({
  virtual_text = false,
})

local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require("lspconfig")

  local servers = {
    "bashls",
    "cssls",
    "emmet_ls",
    "html",
    "rust_analyzer",
    "solidity_ls",
    "tsserver",
  }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = attach,
      capabilities = capabilities,
    })
  end
end

return M
