return {
  event = "VimEnter",
  config = function()
    -- require("mini.bufremove").setup()
    require("mini.surround").setup()
    require("mini.map").setup()
  end,
}
