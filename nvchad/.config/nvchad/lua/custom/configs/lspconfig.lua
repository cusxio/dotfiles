local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- local lspconfig = require("lspconfig")

require("typescript").setup({
  go_to_source_definition = {
    fallback = true,
  },
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
})

-- local servers = { "tsserver" }
--
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--   })
-- end
