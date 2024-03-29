return {
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = { timeout = 300 },
  },
  {
    "famiu/bufdelete.nvim",
    keys = {
      {
        "<leader>c",
        function()
          require("bufdelete").bufdelete(0, false)
        end,
        desc = "Close buffer",
      },
      {
        "<leader>C",
        function()
          require("bufdelete").bufdelete(0, true)
        end,
        desc = "Force close buffer",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      check_ts = true,
      ts_config = {
        -- typescriptreact = { "import_specifier", "jsx_opening_element" },
        javascript = { "string", "template_string" },
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ts_utils = require("nvim-treesitter.ts_utils")
      -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      -- https://github.com/windwp/nvim-autopairs/issues/242
      require("cmp").event:on("confirm_done", function(evt)
        local filetypes =
          { "javascript", "typescript", "javascriptreact", "typescriptreact" }
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")

        if vim.tbl_contains(filetypes, filetype) then
          local node_type = ts_utils.get_node_at_cursor():type()
          if node_type ~= "named_imports" then
            cmp_autopairs.on_confirm_done()(evt)
          end
        else
          cmp_autopairs.on_confirm_done()(evt)
        end
      end)
    end,
  },
  -- {
  --   "echasnovski/mini.cursorword",
  --   config = true,
  --   event = "BufRead",
  -- },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    opts = {
      delay = 1000,
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufRead",
    config = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
  },
  {
    "junegunn/vim-slash",
    event = "BufRead",
    config = function()
      vim.cmd([[noremap <plug>(slash-after) zz]])
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "BufRead",
    dependencies = {
      {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
          require("leap").add_default_mappings()
        end,
      },
    },
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "tsx",
          "lua",
          "comment",
          "astro",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
          -- https://github.com/windwp/nvim-ts-autotag/issues/125
          enable_close_on_slash = false,
        },
        matchup = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
    },
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gb", mode = { "n", "v" } },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufWinEnter",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = {
          "nofile",
          "prompt",
          "help",
          "quickfix",
          "nofile",
        },
        lastplace_open_folds = true,
      })
    end,
  },
}
