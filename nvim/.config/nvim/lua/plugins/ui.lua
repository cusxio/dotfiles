local get_icon = require("utils").get_icon

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = {
      close_if_last_window = true,
      window = {
        width = 30,
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
        follow_current_file = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
    config = function(_, opts)
      vim.g.neo_tree_remove_legacy_commands = true

      require("neo-tree").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>" },
    opts = {
      window = {
        border = "single",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = {
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    enabled = vim.fn.executable("git") == 1,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "󰐊" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "UiEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "WhoIsSethDaniel/lualine-lsp-progress.nvim",
    },
    config = function()
      require("setup.lualine")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },

        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 25,
        },
        border = true,
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },

        -- results_title = false,
        -- sorting_strategy = "ascending",
        -- layout_strategy = "center",
        -- layout_config = {
        --   center = {
        --     anchor = "CENTER",
        --     preview_cutoff = 1,
        --     width = function(_, max_columns, _)
        --       return math.min(max_columns, 80)
        --     end,
        --
        --     height = function(_, _, max_lines)
        --       return math.min(max_lines, 15)
        --     end,
        --   },
        -- },
        --
        -- border = true,
        -- borderchars = {
        --   prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
        --   results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
        --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- },
      },
      extensions_list = { "fzf" },
    },
  },
}
