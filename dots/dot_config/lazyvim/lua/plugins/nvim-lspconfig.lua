---@type LazySpec
return {
  "nvim-lspconfig",
  opts = {
    setup = {
      vtsls = function()
        LazyVim.lsp.on_attach(function(client)
          if client.name == "vtsls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end
        end)
      end,
    },
    inlay_hints = { enabled = false },
  },
}
