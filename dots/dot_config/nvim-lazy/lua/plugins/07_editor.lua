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
    },
    keys = {
      { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory" },
    },
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = { enabled = true },
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
    keys = {
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
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
