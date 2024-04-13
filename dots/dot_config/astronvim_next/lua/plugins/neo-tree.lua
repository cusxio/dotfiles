---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
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
