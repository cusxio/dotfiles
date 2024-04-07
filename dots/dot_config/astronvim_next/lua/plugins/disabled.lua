---@type LazySpec
return vim.tbl_map(function(plugin)
  return { plugin, enabled = false }
end, {
  "goolord/alpha-nvim",
  "nvimtools/none-ls.nvim",
  "jay-babu/mason-null-ls.nvim",
})
