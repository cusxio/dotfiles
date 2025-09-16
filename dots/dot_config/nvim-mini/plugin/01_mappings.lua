local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, opts)
end

nmap_leader("-", "<Cmd>Oil<CR>", "Open parent directory")

nmap_leader("/", "<Cmd>lua Snacks.picker.grep()<CR>", "Grep")
nmap_leader("fb", "<Cmd>lua Snacks.picker.buffers()<CR>", "Buffers")
nmap_leader("ff", "<Cmd>lua Snacks.picker.files()<CR>", "Find Files")
nmap_leader("fd", "<Cmd>lua Snacks.picker.diagnostics()<CR>", "Diagnostics")
nmap_leader(
  "fD",
  "<Cmd>lua Snacks.picker.diagnostics_buffer()<CR>",
  "Buffer Diagnostics"
)

-- jk for escape
lz({
  "better-escape.nvim",
  event = "DeferredUIEnter",
  before = function()
    add("max397574/better-escape.nvim")
  end,
  after = function()
    require("better_escape").setup()
  end,
})
