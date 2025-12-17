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
        -- NOTE: You do not need to add oxlint or eslint_d here, this is only needed
        -- for languages without a lsp server
        -- javascript = { "oxlint", "eslint_d" },
        -- typescript = { "oxlint", "eslint_d" },
        -- javascriptreact = { "oxlint", "eslint_d" },
        -- typescriptreact = { "oxlint", "eslint_d" },
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
    -- cmd = "ConformInfo",
    config = function()
      local formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        javascript = {
          "eslint_d",
          -- "oxlint",
          "prettierd",
        },
        javascriptreact = {
          "eslint_d",
          -- "oxlint",
          "prettierd",
        },
        typescript = {
          "eslint_d",
          -- "oxlint",
          "prettierd",
        },
        typescriptreact = {
          "eslint_d",
          -- "oxlint",
          "prettierd",
        },
        yaml = { "eslint_d", "prettierd" },
        json = { "eslint_d", "prettierd" },
        jsonc = { "eslint_d", "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
      }

      -- local function has_pkg(pkg)
      --   return function(_, ctx)
      --     local found = vim.fs.find(
      --       { "node_modules/" .. pkg },
      --       { path = ctx.dirname, upward = true, type = "directory" }
      --     )
      --     return not vim.tbl_isempty(found)
      --   end
      -- end

      -- local util = require("conform.util")
      require("conform").setup({
        format_on_save = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
        formatters_by_ft = formatters_by_ft,
        -- formatters = {
        --   eslint_d = {
        --     condition = has_pkg("eslint"),
        --   },
        -- oxlint = {
        --   command = util.from_node_modules("oxlint"),
        --   cwd = util.root_file({ "package.json" }),
        --   args = {
        --     "--fix",
        --     "--fix-suggestions",
        --     "--fix-dangerously",
        --     "$FILENAME",
        --   },
        --   exit_codes = { 0, 2 }, -- code 2 is given when the file includes some non-autofixable errors
        --   stdin = true,
        --   -- tmpfile_format = "ConformOxlint$FILENAME",
        --   condition = has_pkg("oxlint"),
        -- },
        -- },
      })
    end,
  },
}
