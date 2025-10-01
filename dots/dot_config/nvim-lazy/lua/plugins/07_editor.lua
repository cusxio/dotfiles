---@type LazySpec
return {
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        autosave_changes = true,
      },
    },
  },
  -- {
  --   "dmtrKovalenko/fff.nvim",
  --   build = function()
  --     require("fff.download").download_or_build_binary()
  --   end,
  --   opts = {
  --     debug = {
  --       enabled = true,
  --       show_scores = true,
  --     },
  --   },
  --   lazy = false,
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          files = {
            hidden = true,
          },
        },
      },
      dashboard = {
        enabled = true,
        formats = {
          header = function()
            local header = [[
██████╗  ██████╗     ██╗  ██╗ █████╗ ██████╗ ██████╗
██╔══██╗██╔═══██╗    ██║  ██║██╔══██╗██╔══██╗██╔══██╗
██║  ██║██║   ██║    ███████║███████║██████╔╝██║  ██║
██║  ██║██║   ██║    ██╔══██║██╔══██║██╔══██╗██║  ██║
██████╔╝╚██████╔╝    ██║  ██║██║  ██║██║  ██║██████╔╝
╚═════╝  ╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝

████████╗██╗  ██╗██╗███╗   ██╗ ██████╗ ███████╗
╚══██╔══╝██║  ██║██║████╗  ██║██╔════╝ ██╔════╝
   ██║   ███████║██║██╔██╗ ██║██║  ███╗███████╗
   ██║   ██╔══██║██║██║╚██╗██║██║   ██║╚════██║
   ██║   ██║  ██║██║██║ ╚████║╚██████╔╝███████║
   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
]]

            return { header, align = "center", hl = "special" }
          end,
        },
        sections = {
          { section = "header" },
          { section = "startup" },
        },
      },
    },
  },
  {
    "nvim-mini/mini.diff",
    event = vim.g.lazy_file_events,
    opts = {
      view = {
        style = "sign",
        signs = { add = "▎", change = "▎", delete = "▎" },
      },
    },
  },
}
