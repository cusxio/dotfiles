---@type LazySpec
return vim.tbl_map(function(plugin)
  return { plugin, enabled = false }
end, {
  "AstroNvim/astrotheme",
  "goolord/alpha-nvim",
  "jay-babu/mason-null-ls.nvim",
  "kevinhwang91/nvim-ufo",
  "nvimtools/none-ls.nvim",
  "stevearc/aerial.nvim",
  "stevearc/resession.nvim",
})
