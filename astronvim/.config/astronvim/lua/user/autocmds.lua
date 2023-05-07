-- https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-or-suspending-and-resuming-nvim
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    vim.cmd([[set guicursor=a:ver100]])
  end,
})
