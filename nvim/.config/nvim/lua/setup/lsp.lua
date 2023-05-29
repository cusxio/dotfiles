local get_icon = require("utils").get_icon

local M = {}

M.init = function()
  local signs = {
    {
      name = "DiagnosticSignError",
      text = get_icon("DiagnosticError"),
      texthl = "DiagnosticSignError",
    },
    {
      name = "DiagnosticSignWarn",
      text = get_icon("DiagnosticWarn"),
      texthl = "DiagnosticSignWarn",
    },
    {
      name = "DiagnosticSignHint",
      text = get_icon("DiagnosticHint"),
      texthl = "DiagnosticSignHint",
    },
    {
      name = "DiagnosticSignInfo",
      text = get_icon("DiagnosticInfo"),
      texthl = "DiagnosticSignInfo",
    },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, sign)
  end
end

M.config = function()
  local on_attach = function(client, bufnr)
    local capabilities = client.server_capabilities

    capabilities.documentFormattingProvider = false
    capabilities.documentRangeFormattingProvider = false

    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>ld", vim.diagnostic.open_float, "Hover diagnostic")
    nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    nmap("d]", vim.diagnostic.goto_next, "Next diagnostic")

    if capabilities.renameProvider then
      nmap("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
    end
    if capabilities.codeActionProvider then
      nmap("<leader>la", vim.lsp.buf.code_action, "LSP code action")
    end

    if capabilities.definitionProvider then
      nmap(
        "gd",
        vim.lsp.buf.definition,
        "Show the definition of current symbol"
      )
    end

    if capabilities.declarationProvider then
      nmap("gD", vim.lsp.buf.declaration, "Declaration of current symbol")
    end

    if capabilities.implementationProvider then
      nmap("gI", vim.lsp.buf.implementation, "Implementation of current symbol")
    end

    if capabilities.typeDefinitionProvider then
      nmap("gT", vim.lsp.buf.type_definition, "Definition of current type")
    end

    if capabilities.hoverProvider then
      nmap("K", vim.lsp.buf.hover, "Hover symbol details")
    end

    if capabilities.signatureHelpProvider then
      nmap("<leader>lh", vim.lsp.buf.signature_help, "Signature help")
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local servers = {
    tsserver = {},
    lua_ls = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
          },
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
        },
      },
    },
  }

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
end

return M
