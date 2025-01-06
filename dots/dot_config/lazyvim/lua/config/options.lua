vim.g.lazyvim_prettier_needs_config = true
-- vim.opt.pumblend = 0

vim.filetype.add({
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    [".*/ghostty/config"] = "config",
    [".*/git/config"] = "ini",
    ["%.env%.[%w_.-]+"] = "sh",
    ["uv.lock"] = "toml",
  },
})

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
