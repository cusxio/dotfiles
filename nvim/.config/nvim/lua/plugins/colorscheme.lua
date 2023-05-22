return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
        override = function(c)
          return {
            NeoTreeCursorLine = { bold = false },
            NeoTreeFileNameOpened = { bold = false },
            NeoTreeRootName = { bold = false },
            NeoTreeGitConflict = { bold = false },
            NeoTreeTabActive = { bold = false },
            StatusLine = {
              bg = c.editor.background,
            },
          }
        end,
      })

      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
