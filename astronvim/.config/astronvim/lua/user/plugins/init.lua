return {
  ["declancm/cinnamon.nvim"] = { disable = true },
  ["Darazaki/indent-o-matic"] = { disable = true },
  ["nmac427/guess-indent.nvim"] = {
    event = "BufReadPost",
    config = function()
      require("guess-indent").setup()
    end,
  },
  ["echasnovski/mini.nvim"] = {
    event = "VimEnter",
    config = function()
      require("mini.surround").setup()
    end,
  },
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
    after = "nvim-lsp-installer",
    config = function()
      require("typescript").setup({
        server = astronvim.lsp.server_settings("tsserver"),
      })
    end,
  },
}
