return {
  ["declancm/cinnamon.nvim"] = { disable = true },

  -- ["Darazaki/indent-o-matic"] = { disable = true },
  -- ["nmac427/guess-indent.nvim"] = {
  --   event = "BufReadPost",
  --   config = function()
  --     require("guess-indent").setup()
  --   end,
  -- },

  ["echasnovski/mini.nvim"] = require("user.plugins.mini"),
  ["rebelot/kanagawa.nvim"] = {
    as = "kanagawa",
    config = function()
      require("kanagawa").setup({
        keywordStyle = {
          italic = false,
        },
        statementStyle = {
          italic = false,
        },
        variablebuiltinStyle = {
          italic = false,
        },
      })
    end,
  },
  ["jose-elias-alvarez/typescript.nvim"] = {
    after = "mason-lspconfig.nvim",
    config = function()
      require("typescript").setup({
        server = astronvim.lsp.server_settings("tsserver"),
      })
    end,
  },
  ["ggandor/leap.nvim"] = {
    requires = { "tpope/vim-repeat" },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  { "gpanders/editorconfig.nvim" },
}
