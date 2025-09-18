local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  local modes = type(mode) == "string" and { mode } or mode

  ---@param m string
  modes = vim.tbl_filter(function(m)
    return not (keys.have and keys:have(lhs, m))
  end, modes)

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

local function nmap_leader(suffix, rhs, opts)
  map("n", "<Leader>" .. suffix, rhs, opts)
end

-- stylua: ignore start
-- better up/down
map({ "n", "x" }, "j",    "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up",   expr = true, silent = true })

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window",  remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]",      { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]",      { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]",      { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]",      { expr = true, desc = "Prev Search Result" })

-- f is for 'fuzzy find'
nmap_leader("f/", "<Cmd>lua Snacks.picker.grep()<CR>",    { desc = "Grep Files" })
nmap_leader("fb", "<Cmd>lua Snacks.picker.buffers()<CR>", { desc = "Buffers" })
nmap_leader("ff", "<Cmd>lua Snacks.picker.files()<CR>",   { desc = "Find Files" })

-- l is for lsp
local formatting_cmd = '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>'
nmap_leader("la", "<Cmd>lua vim.lsp.buf.code_action()<CR>",   { desc = "Actions" })
nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Diagnostics popup" })
nmap_leader("lf", formatting_cmd,                             { desc = "Format" })
nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>",        { desc = "Rename" })

map("n", "K",  "<Cmd>lua vim.lsp.buf.hover()<CR>",                  { desc = "Hover" })
map("n", "gI", "<Cmd>lua Snacks.picker.lsp_implementations()<CR>",  { desc = "Go to Implementation" })
map("n", "gr", "<Cmd>lua Snacks.picker.lsp_references()<CR>",       { desc = "References" })
map("n", "gy", "<Cmd>lua Snacks.picker.lsp_type_definitions()<CR>", { desc = "Go to T[y]pe Definition" })
map("n", "gd", "<Cmd>lua Snacks.picker.lsp_definitions()<CR>",      { desc = "Go to Definition" })
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>",            { desc = "Go to Declaration" })
map("n", "gK", "<Cmd>lua vim.lsp.buf.signature_help()<CR>",         { desc = "Signature Help" })

-- s is for search
nmap_leader("sH", "<Cmd>lua Snacks.picker.highlights()<CR>", { desc = "Highlights" })
-- stylua: ignore end
