local M = {}

M.init = function()
  vim.g.neo_tree_remove_legacy_commands = true

  local set = vim.keymap.set
  set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
  set("n", "<leader>o", function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd.wincmd("p")
    else
      vim.cmd.Neotree("focus")
    end
  end, {
    desc = "Toggle Explorer Focus",
  })
end

M.config = function()
  local get_icon = require("utils").get_icon
  require("neo-tree").setup({
    close_if_last_window = true,
    window = {
      width = 30,
      mappings = {
        ["<C-s>"] = "split_with_window_picker",
        ["<C-v>"] = "vsplit_with_window_picker",
      },
    },
    default_component_configs = {
      indent = { padding = 0, indent_size = 1 },
      modified = { symbol = get_icon("FileModified") },
      git_status = {
        symbols = {
          added = get_icon("GitAdd"),
          deleted = get_icon("GitDelete"),
          modified = get_icon("GitChange"),
          renamed = get_icon("GitRenamed"),
          untracked = get_icon("GitUntracked"),
          ignored = get_icon("GitIgnored"),
          unstaged = get_icon("GitUnstaged"),
          staged = get_icon("GitStaged"),
          conflict = get_icon("GitConflict"),
        },
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  })
end

return M
