local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/nvim-mini/mini.nvim",
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local MiniDeps = require("mini.deps")
MiniDeps.setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add("lumen-oss/lz.n")
end)

now(function()
  add("folke/snacks.nvim")
end)

-- @param spec lz.n.Spec
-- local lz = function(spec)
--   require("lz.n").load(spec)
-- end
-- only use lz.n as a "require" sorter
vim.g.lz_n = { load = function() end }

---@type fun(spec: lz.n.Spec)
_G.lz = require("lz.n").load

_G.add = add
_G.later = later
_G.now = now
_G.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
