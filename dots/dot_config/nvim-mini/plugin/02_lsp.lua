local function mason_tools_install(tools)
  local mr = require("mason-registry")
  local opts = { title = "Mason" }
  for _, tool in ipairs(tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO, opts)

      p:install():once("closed", function()
        if p:is_installed() then
          vim.notify(
            "Successfully installed " .. tool,
            vim.log.levels.INFO,
            opts
          )
        else
          vim.notify("Failed to install " .. tool, vim.log.levels.ERROR, opts)
        end
      end)
    end
  end
end

later(function()
  add({
    source = "mason-org/mason-lspconfig.nvim",
    depends = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  })
end)

lz({
  "mason",
  event = lazy_file_events,
  after = function()
    require("mason").setup()

    local tools = {
      "selene",
      "stylua",
      "shfmt",
      "prettierd",
      "eslint_d",
    }

    mason_tools_install(tools)

    local lsp_servers =
      { "lua_ls", "fish_lsp", "vtsls", "eslint", "tailwindcss", "typos_lsp" }
    require("mason-lspconfig").setup({
      ensure_installed = lsp_servers,
    })
  end,
})

later(function()
  add("folke/lazydev.nvim")
end)

lz({
  "lazydev",
  ft = "lua",
  after = function()
    require("lazydev").setup({
      library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
    })
  end,
})
