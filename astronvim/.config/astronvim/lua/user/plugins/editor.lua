return {
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  {
    "folke/trouble.nvim",
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
  { import = "astrocommunity.project.nvim-spectre" },
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
}
