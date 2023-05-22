local overrides = require("custom.configs.overrides")

local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  --
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
      },
      extensions_list = { "themes", "terms", "fzf" },
    },
  },

  -- extend default opts
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = overrides.treesitter,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  -- personal
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = { timeout = 300 },
  },

  {
    "nvim-treesitter/playground",
    lazy = false,
  },
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   lazy = false,
  --   config = function()
  --     vim.cmd([[colorscheme monokai-pro]])
  --   end,
  --   opts = {
  --     filter = "spectrum",
  --     devicons = true,
  --     transparent_background = false,
  --     override = function()
  --       return {
  --         NeoTreeCursorLine = {
  --           bold = false,
  --         },
  --         NeoTreeFileNameOpened = {
  --           bold = false,
  --         },
  --         NeoTreeRootName = {
  --           bold = false,
  --         },
  --         NeoTreeGitConflict = {
  --           bold = false,
  --         },
  --         NeoTreeTabActive = {
  --           bold = false,
  --         },
  --       }
  --     end,
  --   },
  -- },
}

return plugins
