return {
  servers = {
    "astro",
    "bashls",
    "cssls",
    "emmet_ls",
    "gopls",
    "html",
    "rust_analyzer",
    "solidity_ls",
    "tsserver",
  },
  skip_setup = { "tsserver" },
  ["server-settings"] = {
    gopls = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
      end,
    },
    astro = {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
      end,
    },
    emmet_ls = {
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
      },
    },
  },
}
