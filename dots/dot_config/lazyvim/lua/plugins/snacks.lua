---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      animate = {
        enabled = false,
      },
    },
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
