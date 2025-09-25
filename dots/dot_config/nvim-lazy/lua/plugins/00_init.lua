local function mason_tools_install(tools)
  local mr = require("mason-registry")
  local opts = { title = "Mason" }
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO, opts)

      p:install():once("closed", function()
        if p:is_installed() then
          vim.notify("Successfully installed " .. tool, vim.log.levels.INFO, opts)
        else
          vim.notify("Failed to install " .. tool, vim.log.levels.ERROR, opts)
        end
      end)
    end
  end
end

---@type LazySpec
return {
  -- lsp
  {
    "mason-org/mason-lspconfig.nvim",
    event = vim.g.lazy_file_events,
    opts = {
      ensure_installed = {
        "lua_ls",
        "fish_lsp",
        "vtsls",
        "eslint",
        "tailwindcss",
        "typos_lsp",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.diagnostic.config({
        float = {
          border = "solid",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "▪",
            [vim.diagnostic.severity.WARN] = "▪",
            [vim.diagnostic.severity.INFO] = "▪",
            [vim.diagnostic.severity.HINT] = "▪",
          },
        },
        virtual_text = false,
        -- virtual_text = {
        --   current_line = true,
        --   source = "if_many",
        --   prefix = "▪",
        -- },
      })
    end,
    dependencies = {
      {
        "mason-org/mason.nvim",
        config = function()
          require("mason").setup()

          local tools = {
            "selene",
            "stylua",
            "shfmt",
            "prettierd",
            "eslint_d",
          }

          mason_tools_install(tools)
        end,
      },
      { "neovim/nvim-lspconfig" },
    },
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = vim.g.lazy_file_events,
    config = function()
      local ensure_installed = {
        "typescript",
        "tsx",
        "lua",
        "comment",
        "astro",
        "html",
        "javascript",
        "json",
        "jsonc",
        "html",
        "yaml",
        "toml",
        "diff",
        "markdown",
        "regex",
        "vim",
      }

      -- https://github.com/echasnovski/nvim/blob/5d0a752aad40b08f88aee45fdcd25dc970aeb0a3/plugin/21_plugins.lua#L23-L31
      local isnt_installed = function(lang)
        return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
      end
      local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Ensure enabled
      local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()

      local ts_start = function(ev)
        vim.treesitter.start(ev.buf)
      end
      vim.api.nvim_create_autocmd("FileType", { pattern = filetypes, callback = ts_start })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = vim.g.lazy_file_events,
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    opts = {},
  },
}
