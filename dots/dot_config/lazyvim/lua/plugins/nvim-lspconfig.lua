---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        -- https://github.com/yioneko/vtsls/issues/167#issuecomment-2162166505
        root_dir = function()
          local lazyvimRoot = require("lazyvim.util.root")
          return lazyvimRoot.git()
        end,
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
