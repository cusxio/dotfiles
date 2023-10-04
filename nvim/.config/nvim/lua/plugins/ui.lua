return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = {
          hint = "floating-big-letter",
        },
        -- opts = {
        --   filter_rules = {
        --     bo = { filetype = { "neo-tree" }, buftype = { "quickfix" } },
        --   },
        --   use_winbar = "always",
        --   fg_color = "#7fb4ca",
        --   current_win_hl_color = "#1a1a22",
        --   other_win_hl_color = "#1a1a22",
        -- },
      },
    },
    cmd = "Neotree",
    init = require("setup.neo-tree").init,
    config = require("setup.neo-tree").config,
  }, -- {
  --   "nvim-tree/nvim-tree.lua",
  --   cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   init = function()
  --     local set = vim.keymap.set
  --     set(
  --       "n",
  --       "<leader>e",
  --       "<cmd>NvimTreeToggle<cr>",
  --       { desc = "Toggle Explorer" }
  --     )
  --     set(
  --       "n",
  --       "<leader>o",
  --       "<cmd>NvimTreeFocus<cr>",
  --       { desc = "Focus Explorer" }
  --     )
  --   end,
  --   opts = {
  --     disable_netrw = true,
  --     hijack_cursor = true,
  --     hijack_netrw = true,
  --
  --     view = {
  --       side = "left",
  --       width = 30,
  --       signcolumn = "auto",
  --       preserve_window_proportions = false,
  --     },
  --     update_focused_file = {
  --       enable = true,
  --     },
  --     renderer = {
  --       highlight_git = true,
  --       icons = {
  --         show = {
  --           git = false,
  --         },
  --         -- glyphs = {
  --         --   folder = {
  --         --     default = "",
  --         --     open = "",
  --         --   },
  --         -- },
  --       },
  --     },
  --     actions = {
  --       open_file = {
  --         window_picker = {
  --           enable = false,
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "mrjones2014/smart-splits.nvim",
    dependencies = { "kwkarlwang/bufresize.nvim" },
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
      ignored_buftypes = { "nofile" },
      -- resize_mode = {
      --   hooks = {
      --     on_leave = require("bufresize").register,
      --   },
    },
    init = function()
      local set = vim.keymap.set
      set("n", "<C-w>h", function()
        require("smart-splits").move_cursor_left()
      end, {
        desc = "Go to the left window",
      })
      set("n", "<C-w>j", function()
        require("smart-splits").move_cursor_down()
      end, {
        desc = "Go to the down window",
      })
      set("n", "<C-w>k", function()
        require("smart-splits").move_cursor_up()
      end, {
        desc = "Go to the up window",
      })
      set("n", "<C-w>l", function()
        require("smart-splits").move_cursor_right()
      end, {
        desc = "Go to the right window",
      })
    end,
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
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = {
          show_start = false,
          show_end = false,
          highlight = { "IndentBlanklineContextChar" },
        },
        exclude = {
          buftypes = {
            "nofile",
            "terminal",
          },
          filetypes = {
            "help",
            "neo-tree",
          },
        },
      })

      local hooks = require("ibl.hooks")
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    enabled = vim.fn.executable("git") == 1,
    opts = {
      signs = {
        add = {
          text = "▎",
        },
        change = {
          text = "▎",
        },
        delete = {
          text = "▎",
        },
        topdelete = {
          text = "󰐊",
        },
        changedelete = {
          text = "▎",
        },
        untracked = {
          text = "▎",
        },
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
  }, -- {
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
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    init = require("setup.telescope").init,
    config = require("setup.telescope").config,
  },
}
