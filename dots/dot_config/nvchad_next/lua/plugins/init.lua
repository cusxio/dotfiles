local overrides = require("configs.overrides")

return {
  -- override defaults
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      {
        "andymass/vim-matchup",
        config = function()
          vim.g.matchup_matchparen_deferred = 1
        end,
      },
    },
    opts = overrides.treesitter,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.indent,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
  -- lsp
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("configs.lsp")
    end,
    event = "User FilePost",
    dependencies = {
      {
        "nvimtools/none-ls.nvim",
        config = function()
          local null_ls = require("null-ls")
          local augroup = vim.api.nvim_create_augroup("format_on_save", {})

          null_ls.setup({
            sources = {
              null_ls.builtins.diagnostics.fish,
              null_ls.builtins.formatting.fish_indent,
            },
            debug = true,
            on_attach = function(client, bufnr)
              if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({
                      filter = function(client2)
                        return client2.name ~= "tsserver"
                            and client2.name ~= "jsonls"
                      end,
                      bufnr,
                      timeout_ms = 5000,
                    })
                  end,
                })
              end
            end,
          })
        end,
      },
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
          "nvimtools/none-ls.nvim",
          "nvimtools/none-ls-extras.nvim",
        },
        opts = {
          ensure_installed = {
            "prettierd",
            "shfmt",
            "stylua",
            "eslint_d",
            "shellcheck",
          },
          handlers = {
            eslint_d = function()
              local null_ls = require("null-ls")
              null_ls.register(require("none-ls.diagnostics.eslint_d"))
              null_ls.register(require("none-ls.formatting.eslint_d"))
              null_ls.register(require("none-ls.code_actions.eslint_d"))
            end,
            prettierd = function()
              local null_ls = require("null-ls")
              null_ls.register(null_ls.builtins.formatting.prettierd.with({
                extra_filetypes = { "astro" },
              }))
            end,
          },
        },
      },
    },
  },
  -- other
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = { timeout = 300 },
  },
  {
    "junegunn/vim-slash",
    event = "BufRead",
    config = function()
      vim.cmd([[noremap <plug>(slash-after) zz]])
    end,
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      local leap = require("leap")
      vim.keymap.set("n", "s", function()
        require("leap").leap({
          target_windows = { vim.api.nvim_get_current_win() },
        })
      end)
      leap.add_default_mappings(true)
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    config = function()
      require("flit").setup({
        keys = { f = "f", F = "F", t = "t", T = "T" },
        labeled_modes = "n",
      })
    end,
    dependencies = {
      "ggandor/leap.nvim",
      "tpope/vim-repeat",
    },
  },
}
