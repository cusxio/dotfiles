return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
      defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
      },
    })
  end,
}
