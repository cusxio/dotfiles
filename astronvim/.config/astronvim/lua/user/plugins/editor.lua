return {
  {
    "ggandor/flit.nvim",
    event = "User AstroFile",
  },
  {
    "ggandor/leap.nvim",
    event = "User AstroFile",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function(...)
      -- run AstroNvim core lspconfig setup
      require("plugins.configs.lspconfig")(...)

      -- setup custom hover handler
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(_, result, ctx, config)
        config = config or {}
        config.focus_id = ctx.method
        if not (result and result.contents) then
          return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end, { border = "rounded" })
    end,
  },
}
