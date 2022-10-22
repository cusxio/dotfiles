return {
  requires = { "tpope/vim-repeat" },
  config = function()
    require("leap").set_default_keymaps()
  end,
}
