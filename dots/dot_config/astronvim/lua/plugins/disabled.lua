---@type LazySpec
return vim.tbl_map(function(plugin)
  return { plugin, enabled = false }
end, {
  "AstroNvim/astrotheme",
  "stevearc/resession.nvim",
  "nvimtools/none-ls.nvim",
})
