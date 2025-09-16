later(function()
  add("stevearc/oil.nvim")
end)

lz({
  "oil.nvim",
  cmd = "Oil",
  after = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
    })
  end,
})
