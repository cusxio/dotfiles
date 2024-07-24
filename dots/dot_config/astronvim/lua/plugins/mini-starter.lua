---@type LazySpec
return {
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
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>c"] = {
              function()
                local bufs = vim.fn.getbufinfo({ buflisted = true })
                require("astrocore.buffer").close(0)
                if
                  require("astrocore").is_available("mini.starter")
                  and not bufs[2]
                then
                  require("mini.starter").open()
                  require("astrocore.buffer").close_all(true) -- remove empty buffer
                end
              end,
              desc = "Close buffer",
            },
          },
        },
      },
    },
  },
}
