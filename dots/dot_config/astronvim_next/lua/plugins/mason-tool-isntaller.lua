-- helper function to setup a plugin without an `ensure_installed` table
local setup_without_ensure_installed = function(main, opts)
  opts = vim.deepcopy(opts)
  opts.ensure_installed = nil
  require(main).setup(opts)
end

local noop = function() end

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function(plugin)
      require("astrocore").on_load("mason.nvim", plugin.name)
    end,
    opts = {
      ensure_installed = {
        -- Language Servers
        "astro",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "tailwindcss",
        "vtsls",
        "yamlls",

        -- Linters
        "selene",
        "shellcheck",
        -- "eslint",
        "eslint_d",

        -- Formatters
        "prettierd",
        "shfmt",
        "stylua",
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require("mason-tool-installer")
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
  -- disable init and ensure installed of other plugins
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    init = noop,
    config = function(_, opts)
      setup_without_ensure_installed("mason-nvim-dap", opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    init = noop,
    config = function(_, opts)
      setup_without_ensure_installed("mason-lspconfig", opts)
    end,
  },
}
