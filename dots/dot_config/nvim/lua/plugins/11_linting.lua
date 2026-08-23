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
          lsp_format = "never",
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

      format.register_lsp_command("oxlint", 250, "oxc.fixAll", function(buf)
        return { { uri = vim.uri_from_bufnr(buf) } }
      end)
      format.register_lsp("eslint", 200)
      format.register_lsp("oxfmt", 150)
      format.register({
        name = "conform",
        primary = true,
        priority = 100,
        format = function(buf)
          require("conform").format({ bufnr = buf })
        end,
        sources = function(buf)
          return vim.tbl_map(function(f) return f.name end, require("conform").list_formatters(buf))
        end,
      })
    end,
  },
}
