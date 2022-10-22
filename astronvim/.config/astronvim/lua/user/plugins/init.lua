return {
  -- ["Darazaki/indent-o-matic"] = { disable = true },
  -- ["nmac427/guess-indent.nvim"] = {
  --   event = "BufReadPost",
  --   config = function()
  --     require("guess-indent").setup()
  --   end,
  -- },
  ["nanotee/sqls.nvim"] = require("user.plugins.sqls"),
  ["rebelot/kanagawa.nvim"] = require("user.plugins.kanagawa"),
  ["echasnovski/mini.nvim"] = require("user.plugins.mini"),
  ["jose-elias-alvarez/typescript.nvim"] = require("user.plugins.typescript"),
  ["ggandor/leap.nvim"] = require("user.plugins.leap"),
  { "gpanders/editorconfig.nvim" },
  -- { "Yazeed1s/oh-lucy.nvim" },
}
