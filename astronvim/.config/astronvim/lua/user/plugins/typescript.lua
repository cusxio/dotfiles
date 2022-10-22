return {
  after = "mason-lspconfig.nvim",
  config = function()
    require("typescript").setup({
      server = astronvim.lsp.server_settings("tsserver"),
    })
  end,
}
