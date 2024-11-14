vim.g.lazyvim_prettier_needs_config = true
vim.opt.pumblend = 0

vim.filetype.add({
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    ["%.env%.[%w_.-]+"] = "sh",
    ["uv.lock"] = "toml",
  },
})
