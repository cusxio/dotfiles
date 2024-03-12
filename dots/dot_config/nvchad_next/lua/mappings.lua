require("nvchad.mappings")

local map = vim.keymap.set

map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
