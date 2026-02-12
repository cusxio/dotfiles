---@type LazySpec
return {
  {
    "dmmulroy/ts-error-translator.nvim",
    event = vim.g.lazy_file_events,
    opts = {},
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = vim.g.lazy_file_events,
    opts = {
      preset = "simple",
      signs = {
        diag = "▪",
      },
      options = {
        show_source = {
          if_many = true,
        },
        multilines = true,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = vim.g.lazy_file_events,
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        fish = { "fish" },
        lua = { "selene" },
      }

      local function debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = vim.g.lazy_file_events,
    config = function()
      local format = require("util.format")

      require("conform").setup({
        default_format_opts = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          sh = { "shfmt" },
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          yaml = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          css = { "prettierd" },
          html = { "prettierd" },
        },
        formatters = {
          prettierd = {
            require_cwd = true,
          },
        },
      })

      -- Register ESLint LSP formatter (runs first)
      format.register({
        name = "eslint",
        primary = false,
        priority = 200,
        format = function(buf)
          vim.lsp.buf.format({
            bufnr = buf,
            async = false,
            filter = function(client)
              return client.name == "eslint"
            end,
          })
        end,
        sources = function(buf)
          local clients = vim.lsp.get_clients({ bufnr = buf, name = "eslint" })
          if #clients > 0 then
            return { "eslint" }
          end
          return {}
        end,
      })

      -- Register oxfmt LSP formatter
      format.register({
        name = "oxfmt",
        primary = false,
        priority = 150,
        format = function(buf)
          vim.lsp.buf.format({
            bufnr = buf,
            async = false,
            filter = function(client)
              return client.name == "oxfmt"
            end,
          })
        end,
        sources = function(buf)
          local clients = vim.lsp.get_clients({ bufnr = buf, name = "oxfmt" })
          if #clients > 0 then
            return { "oxfmt" }
          end
          return {}
        end,
      })

      -- Register conform formatter (runs second)
      format.register({
        name = "conform",
        primary = true,
        priority = 100,
        format = function(buf)
          require("conform").format({ bufnr = buf })
        end,
        sources = function(buf)
          local formatters = require("conform").list_formatters(buf)
          return vim.tbl_map(function(f)
            return f.name
          end, formatters)
        end,
      })
    end,
  },
}
