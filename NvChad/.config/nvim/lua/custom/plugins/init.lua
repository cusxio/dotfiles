return {
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },
  ["numtostr/comment.nvim"] = {
    module = "comment",
    branch = "jsx",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          return require("Comment.jsx").calculate(ctx)
        end,
      })
    end,
  },
}
