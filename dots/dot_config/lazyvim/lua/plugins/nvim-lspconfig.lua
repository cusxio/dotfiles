---@type LazySpec
return {
  "nvim-lspconfig",
  opts = {
    servers = {
      eslint = {
        settings = {
          -- experimental = { useFlatConfig = true },
          workingDirectories = { mode = "auto" },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = false,
            },
          },
        },
      },
    },
    setup = {
      vtsls = function()
        LazyVim.lsp.on_attach(function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end, "vtsls")
      end,
    },
    inlay_hints = { enabled = false },
  },
}
