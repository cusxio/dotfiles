---@type LazySpec
return {
  {
    "echasnovski/mini.starter",
    event = "VimEnter",
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        header = table.concat({
          "The beginning of wisdom is this: Get wisdom.",
          "Though it cost all you have, get understanding.",
          "Proverbs 4:7",
        }, "\n\n"),
        items = {
          { name = "", action = "", section = "" },
        },
        footer = "",
        content_hooks = {
          starter.gen_hook.aligning("center", "center"),
        },
        query_updaters = "",
      })
    end,
  },
}
