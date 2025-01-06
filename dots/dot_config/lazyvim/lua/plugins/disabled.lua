return vim.tbl_map(function(plugin)
  return { plugin, enabled = false }
end, {
  "catppuccin",
  -- "folke/tokyonight.nvim",
})
