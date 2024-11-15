---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
    window = {
      mappings = {
        ["<C-s>"] = "split_with_window_picker",
        ["<C-v>"] = "vsplit_with_window_picker",
      },
    },
  },
}
