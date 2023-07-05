local get_icon = require("utils").get_icon

local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then
    autocmds = { autocmds }
  end
  local cmds_found, cmds =
    pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if not cmds_found or vim.tbl_isempty(cmds) then
    vim.api.nvim_create_augroup(augroup, { clear = false })
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds =
    pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })
  if cmds_found then
    vim.tbl_map(function(cmd)
      vim.api.nvim_del_autocmd(cmd.id)
    end, cmds)
  end
end

local function has_capability(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then
      return true
    end
  end
  return false
end

--

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

    if client.supports_method("textDocument/rename") then
      nmap("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
    end
    if client.supports_method("textDocument/codeAction") then
      nmap("<leader>la", vim.lsp.buf.code_action, "LSP code action")
    end

    if client.supports_method("textDocument/definition") then
      nmap(
        "gd",
        vim.lsp.buf.definition,
        "Show the definition of current symbol"
      )
    end

    if client.supports_method("textDocument/declaration") then
      nmap("gD", vim.lsp.buf.declaration, "Declaration of current symbol")
    end

    if client.supports_method("textDocument/implementation") then
      nmap("gI", vim.lsp.buf.implementation, "Implementation of current symbol")
    end

    if client.supports_method("textDocument/typeDefinition") then
      nmap("gT", vim.lsp.buf.type_definition, "Definition of current type")
    end

    if client.supports_method("textDocument/hover") then
      nmap("K", vim.lsp.buf.hover, "Hover symbol details")
    end

    if client.supports_method("textDocument/signatureHelp") then
      nmap("<leader>lh", vim.lsp.buf.signature_help, "Signature help")
    end

    if client.supports_method("textDocument/documentHighlight") then
      add_buffer_autocmd("lsp_document_highlight", bufnr, {
        {
          events = { "CursorHold", "CursorHoldI" },
          desc = "highlight references when cursor holds",
          callback = function()
            if
              not has_capability(
                "textDocument/documentHighlight",
                { bufnr = bufnr }
              )
            then
              del_buffer_autocmd("lsp_document_highlight", bufnr)
              return
            end
            vim.lsp.buf.document_highlight()
          end,
        },
        {
          events = { "CursorMoved", "CursorMovedI" },
          desc = "clear references when cursor moves",
          callback = function()
            vim.lsp.buf.clear_references()
          end,
        },
      })
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local servers = {
    astro = {},
    cssls = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
    emmet_ls = {},
    tailwindcss = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            -- https://github.com/paolotiu/tailwind-intellisense-regex-list
            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
            -- https://cva.style/docs/installation#intellisense
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          },
        },
        validate = true,
      },
    },
    tsserver = {},
    jsonls = {
      json = {
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "now.json", "vercel.json" },
            url = "https://json.schemastore.org/now.json",
          },
        },
      },
    },
    yamlls = {},
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
      tsserver = function()
        require("typescript").setup({
          go_to_source_definition = {
            fallback = true,
          },
          server = {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers["tsserver"],
          },
        })
      end,
    },
  })
end

return M
