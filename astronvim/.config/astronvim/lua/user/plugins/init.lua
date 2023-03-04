return {
  -- ["Darazaki/indent-o-matic"] = { disable = true },
  -- ["nmac427/guess-indent.nvim"] = {
  --   event = "BufReadPost",
  --   config = function()
  --     require("guess-indent").setup()
  --   end,
  -- },
  ["andymass/vim-matchup"] = { after = "nvim-treesitter" },
  ["ggandor/leap.nvim"] = require("user.plugins.leap"),
  { "gpanders/editorconfig.nvim" },
  ["jose-elias-alvarez/typescript.nvim"] = require("user.plugins.typescript"),
  ["machakann/vim-sandwich"] = {
    opt = true,
    setup = function()
      table.insert(astronvim.file_plugins, "vim-sandwich")
    end,
  },
  ["nanotee/sqls.nvim"] = require("user.plugins.sqls"),
  ["rebelot/kanagawa.nvim"] = require("user.plugins.kanagawa"),
  ["sindrets/diffview.nvim"] = {
    opt = true,
    setup = function()
      table.insert(astronvim.git_plugins, "diffview.nvim")
    end,
  },
  -- { "Yazeed1s/oh-lucy.nvim" },
}
