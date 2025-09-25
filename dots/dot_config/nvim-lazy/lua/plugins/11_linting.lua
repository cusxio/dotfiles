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
        fish = { "fish_lsp" },
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
      local formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        javascript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        yaml = { "eslint_d", "prettierd" },
        json = { "eslint_d", "prettierd" },
        jsonc = { "eslint_d", "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
      }

      require("conform").setup({
        format_on_save = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
        formatters_by_ft = formatters_by_ft,
      })
    end,
  },
}
