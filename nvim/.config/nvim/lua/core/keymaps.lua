local is_available = require("utils").is_available
local set = vim.keymap.set

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
set("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })

if is_available("telescope.nvim") then
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

if is_available("neo-tree.nvim") then
  set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
  set("n", "<leader>o", function()
    if vim.bo.filetype == "neo-tree" then
      vim.cmd.wincmd("p")
    else
      vim.cmd.Neotree("focus")
    end
  end, {
    desc = "Toggle Explorer Focus",
  })
end
