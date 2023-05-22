local servers = {
  tsserver = {},
  lua_ls = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      telemetry = { enable = false },
    },
  },
}

vim.keymap.set(
  "n",
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous diagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  vim.diagnostic.goto_next,
  { desc = "Go to next diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" }
)

local on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities

  capabilities.documentFormattingProvider = false
  capabilities.documentRangeFormattingProvider = false

  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  if capabilities.renameProvider then
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  end
  if capabilities.codeActionProvider then
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  end

  if capabilities.definitionProvider then
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  end

  if capabilities.declarationProvider then
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  end

  if capabilities.implementationProvider then
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  end

  if capabilities.typeDefinitionProvider then
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  end

  if capabilities.hoverProvider then
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  end

  if capabilities.signatureHelpProvider then
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end,
  },
})
