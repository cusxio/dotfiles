---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>o",
      "<cmd>Neotree focus<cr>",
      desc = "NeoTree Focus",
    },
  },
  opts = {
    window = {
      width = 30,
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = "󰬈",
          modified = "󰬔",
          deleted = "󰬋",
          renamed = "󰬙",
          untracked = "󰬛",
          ignored = "󰬐",
          unstaged = "󰬜",
          staged = "󰬚",
          conflict = "󰬊",
        },
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
