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
      local ft_by_formatters = {
        stylua = { "lua" },
        fish_indent = { "fish" },
        shfmt = { "sh" },
        prettierd = {
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "yaml",
          "json",
          "jsonc",
        },
      }

      local formatters_by_ft = {}
      for formatter, fts in pairs(ft_by_formatters) do
        for _, ft in ipairs(fts) do
          formatters_by_ft[ft] = { formatter }
        end
      end

      require("conform").setup({
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
        formatters_by_ft = formatters_by_ft,
      })
    end,
  },
}
