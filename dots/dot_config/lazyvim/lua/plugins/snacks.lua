---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[ Do Hard Things ]],
      },
      sections = {
        { section = "header" },
        { section = "startup" },
      },
    },
  },
}
