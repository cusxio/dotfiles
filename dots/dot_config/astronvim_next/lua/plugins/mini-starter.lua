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
        }, "\n\n"),
        items = {
          { name = "", action = "", section = "" },
        },
        footer = "Proverbs 4:7",
        -- content_hooks = {
        --   starter.gen_hook.aligning("center", "center"),
        -- },
        query_updaters = "",
      })
    end,
  },
}
