return {
  {
    "jose-elias-alvarez/typescript.nvim",
    opts = function()
      return { server = require("astronvim.utils.lsp").config("tsserver") }
    end,
  },
}
