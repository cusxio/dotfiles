local set = vim.keymap.set

set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
set("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })

-- local function close(bufnr, force)
--   if force == nil then
--     force = false
--   end
--   if is_available("bufdelete.nvim") then
--     require("bufdelete").bufdelete(bufnr, force)
--   else
--     vim.cmd((force and "bd!" or "confirm bd") .. (bufnr == nil and "" or bufnr))
--   end
-- end
--
-- set("n", "<leader>c", function()
--   close()
-- end, {
--   desc = "Close buffer",
-- })
--
-- set("n", "<leader>C", function()
--   close(0, true)
-- end, {
--   desc = "Close buffer",
-- })

set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
