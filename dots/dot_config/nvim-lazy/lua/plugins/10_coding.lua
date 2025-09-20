---@type LazySpec
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "nvim-mini/mini.move",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "nvim-mini/mini.align",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "nvim-mini/mini.bracketed",
    event = vim.g.lazy_file_events,
    opts = {
      diagnostic = { options = {
        float = false,
      } },
    },
  },
  -- probably the only comment plugin that support blockwise comments
  {
    "numToStr/Comment.nvim",
    event = vim.g.lazy_file_events,
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "nvim-mini/mini.ai",
    dependencies = { { "nvim-mini/mini.extra" } },
    event = vim.g.lazy_file_events,
    opts = function()
      local ai = require("mini.ai")
      local extra = require("mini.extra")
      return {
        custom_textobjects = {
          B = extra.gen_ai_spec.buffer(),
          F = ai.gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
        },
      }
    end,
  },
  {
    "andymass/vim-matchup",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  -- completion
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    opts = {
      sources = {
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
      },
    },
  },
}
