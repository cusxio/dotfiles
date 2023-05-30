return {
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   event = { "BufRead", "BufNewFile" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     {
  --       "s1n7ax/nvim-window-picker",
  --       opts = {
  --         filter_rules = {
  --           bo = { filetype = { "neo-tree" }, buftype = { "quickfix" } },
  --         },
  --         use_winbar = "always",
  --         fg_color = "#7fb4ca",
  --         current_win_hl_color = "#1a1a22",
  --         other_win_hl_color = "#1a1a22",
  --       },
  --     },
  --   },
  --   cmd = "Neotree",
  --   init = require("setup.neo-tree").init,
  --   config = require("setup.neo-tree").config,
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      local set = vim.keymap.set
      set(
        "n",
        "<leader>e",
        "<cmd>NvimTreeToggle<cr>",
        { desc = "Toggle Explorer" }
      )
      set(
        "n",
        "<leader>o",
        "<cmd>NvimTreeFocus<cr>",
        { desc = "Focus Explorer" }
      )
    end,
    opts = {
      disable_netrw = true,
      hijack_cursor = true,
      hijack_netrw = true,

      view = {
        side = "left",
        width = 30,
        signcolumn = "auto",
        preserve_window_proportions = true,
      },
      update_focused_file = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = false,
          },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
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
      show_current_context = true,
      show_current_context_start = true,
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
    "rebelot/heirline.nvim",
    event = "BufEnter",
    dependencies = {
      {
        "linrongbin16/lsp-progress.nvim",
        config = true,
      },
    },
    config = function()
      require("setup.heirline")
    end,
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "UiEnter",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     "WhoIsSethDaniel/lualine-lsp-progress.nvim",
  --   },
  --   config = function()
  --     require("setup.lualine")
  --   end,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    init = require("setup.telescope").init,
    config = require("setup.telescope").config,
  },
}
