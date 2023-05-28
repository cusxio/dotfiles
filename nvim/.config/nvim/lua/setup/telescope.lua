local M = {}

M.init = function()
  local set = vim.keymap.set
  set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
  end, { desc = "Find files" })
  set("n", "<leader>fw", function()
    require("telescope.builtin").live_grep()
  end, { desc = "Find words" })
  set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
  end, { desc = "Find buffers" })
  set("n", "<leader>fc", function()
    require("telescope.builtin").grep_string()
  end, { desc = "Find for word under cursor" })
  set("n", "<leader>lD", function()
    require("telescope.builtin").diagnostics()
  end, { desc = "Search diagnostics" })
end

M.config = function()
  require("telescope").setup({
    pickers = {
      find_files = { hidden = true },
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
    },
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },

      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      layout_config = {
        height = 25,
      },
      border = true,
      borderchars = {
        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
        results = { " " },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },

      -- results_title = false,
      -- sorting_strategy = "ascending",
      -- layout_strategy = "center",
      -- layout_config = {
      --   center = {
      --     anchor = "CENTER",
      --     preview_cutoff = 1,
      --     width = function(_, max_columns, _)
      --       return math.min(max_columns, 80)
      --     end,
      --
      --     height = function(_, _, max_lines)
      --       return math.min(max_lines, 15)
      --     end,
      --   },
      -- },
      --
      -- border = true,
      -- borderchars = {
      --   prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      --   results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      -- },
    },
    extensions_list = { "fzf" },
  })
end

return M
