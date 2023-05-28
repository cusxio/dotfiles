local set = vim.keymap.set

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
set("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
