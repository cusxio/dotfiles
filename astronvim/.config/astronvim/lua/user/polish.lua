return function()
  vim.filetype.add({
    extension = {
      astro = "astro",
      conf = "config",
    },
  })

  require("user.autocmds")
end
