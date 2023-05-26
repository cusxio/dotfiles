return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
        background_clear = {
          "float_win",
          "telescope",
          "neo-tree",
          "which-key",
        },
        override = function(c)
          return {
            NeoTreeCursorLine = { bold = false },
            NeoTreeFileNameOpened = { bold = false },
            NeoTreeRootName = { bold = false },
            NeoTreeGitConflict = { bold = false },
            NeoTreeTabActive = { bold = false },
            TelescopeSelection = {
              bg = "#2b2b2b",
              fg = c.base.white,
            },
            TelescopeMatching = {
              fg = c.base.cyan,
            },
            StatusLine = { bg = c.editor.background },
            StatusLineNC = { bg = c.editor.background },
            ColorColumn = { bg = "#2b2b2b" },
          }
        end,
      })

      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
