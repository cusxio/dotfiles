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
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'",                                  { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'",                                  { desc = "Up", expr = true, silent = true   })

-- move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h",                                                          { desc = "Go to Left Window",  remap = true })
map("n", "<C-j>", "<C-w>j",                                                          { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k",                                                          { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l",                                                          { desc = "Go to Right Window", remap = true })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>",                              { desc = "Save File" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'",                                          { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]",                                               { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]",                                               { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'",                                          { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]",                                               { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]",                                               { expr = true, desc = "Prev Search Result" })

-- b is for buffer
nmap_leader("bd", function() Snacks.bufdelete() end,                                 { desc = "Delete Buffer" })
nmap_leader("bo", function() Snacks.bufdelete.other() end,                           { desc = "Delete Other Buffer" })


-- f is for 'fuzzy find'
nmap_leader("fw", function() Snacks.picker.grep() end,                               { desc = "Grep Files" })
nmap_leader("fb", function() Snacks.picker.buffers() end,                            { desc = "Buffers" })
nmap_leader("ff", function() Snacks.picker.files() end,                              { desc = "Find Files" })

-- c is for code, l is for lsp
nmap_leader("ld", function() vim.diagnostic.open_float() end,                        { desc = "Diagnostics popup" })
nmap_leader("lf", function() require("conform").format({ lsp_fallback = true }) end, { desc = "Format" })
nmap_leader("ca", vim.lsp.buf.code_action,                                           { desc = "Actions"})
nmap_leader("cr", function() vim.lsp.buf.rename() end,                               { desc = "Rename" })

map("n", "K", vim.lsp.buf.hover,                                                     { desc = "Hover" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end,                   { desc = "Go to Implementation" })
map("n", "gr", function() Snacks.picker.lsp_references() end,                        { desc = "References" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end,                  { desc = "Go to T[y]pe Definition" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end,                       { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration,                                              { desc = "Go to Declaration" })
map("n", "gK", vim.lsp.buf.signature_help,                                           { desc = "Signature Help" })

-- o is for open/oil
nmap_leader("oc", function() require('oil').open() end,                              { desc = "Open [c]urrent directory" })
nmap_leader("ow", function() require("oil").open(vim.fn.getcwd()) end,               { desc = "Open [w]orkspace directory"       })

-- s is for search
nmap_leader("sH", function() Snacks.picker.highlights() end,                         { desc = "Highlights" })
map({"n", "x", "o"}, 's', function() require("flash").jump() end,                    { desc = "Flash" })
map({"n", "x", "o"}, 'S', function() require("flash").treesitter() end,              { desc = "Flash Treesitter" })
map("o", "r", function() require("flash").remote() end,                              { desc = "Remote flash" })
-- stylua: ignore end

-- treesitter
local moves = {
  goto_next_start = {
    ["]f"] = "@function.outer",
    ["]a"] = "@parameter.inner",
  },
  goto_next_end = {
    ["]F"] = "@function.outer",
    ["]A"] = "@parameter.inner",
  },
  goto_previous_start = {
    ["[f"] = "@function.outer",
    ["[a"] = "@parameter.inner",
  },
  goto_previous_end = {
    ["[F"] = "@function.outer",
    ["[A"] = "@parameter.inner",
  },
}

for func_name, keymap_def in pairs(moves) do
  for lhs, query in pairs(keymap_def) do
    map({ "n", "x", "o" }, lhs, function()
      require("nvim-treesitter-textobjects.move")[func_name](query, "textobjects")
    end)
  end
end
