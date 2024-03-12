---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
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
              null_ls.register(null_ls.builtins.diagnostics.eslint_d)
              null_ls.register(null_ls.builtins.formatting.eslint_d)
              null_ls.register(null_ls.builtins.code_actions.eslint_d)
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
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
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
    opts = {
      ensure_installed = {
        "vim",
        "lua",

        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        "astro",
      },
      matchup = {
        enable = true,
      },
      autotag = {
        enable = true,
        -- https://github.com/windwp/nvim-ts-autotag/issues/125
        enable_close_on_slash = false,
      },
    },
  },
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    init = function() -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append({ "a:Cursor/lCursor" })
        end,
        pattern = "LeapEnter",
      })
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
        end,
        pattern = "LeapLeave",
      })
    end,
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
}

return plugins
