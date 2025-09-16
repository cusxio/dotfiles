later(function()
  add("mfussenegger/nvim-lint")
  add("stevearc/conform.nvim")
end)

lz({
  "conform.nvim",
  event = lazy_file_events,
  after = function()
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
})

lz({
  "nvim-lint",
  event = lazy_file_events,
  after = function()
    local M = {}
    local lint = require("lint")

    lint.linters_by_ft = {
      fish = { "fish_lsp" },
      lua = { "selene" },
    }

    function M.debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        timer:stop()
        timer:start(ms, 0, function()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      -- Use nvim-lint's logic first:
      -- * checks if linters exist for the full filetype first
      -- * otherwise will split filetype by "." and add all those linters
      -- * this differs from conform.nvim which only uses the first filetype that has a formatter
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- Create a copy of the names table to avoid modifying the original.
      names = vim.list_extend({}, names)

      -- Add fallback linters.
      if #names == 0 then
        vim.list_extend(names, lint.linters_by_ft["_"] or {})
      end

      -- Add global linters.
      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      -- Filter out linters that don't exist or don't match the condition.
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          vim.notify(
            "Linter not found: " .. name,
            vim.log.levels.WARN,
            { title = "nvim-lint" }
          )
        end
        return linter
          and not (
            type(linter) == "table"
            and linter.condition
            and not linter.condition(ctx)
          )
      end, names)

      -- Run linters.
      if #names > 0 then
        lint.try_lint(names)
      end
    end

    vim.api.nvim_create_autocmd(
      { "BufWritePost", "BufReadPost", "InsertLeave" },
      {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.lint,
      }
    )
  end,
})

later(function()
  add("rachartier/tiny-inline-diagnostic.nvim")
  require("tiny-inline-diagnostic").setup({
    preset = "modern",
    options = {
      show_source = {
        if_many = true,
      },
    },
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "●",
        [vim.diagnostic.severity.WARN] = "●",
        [vim.diagnostic.severity.INFO] = "●",
        [vim.diagnostic.severity.HINT] = "●",
      },
    },
  })
end)
