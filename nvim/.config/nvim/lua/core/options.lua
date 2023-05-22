local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = " "

opt.clipboard = "unnamedplus"
-- opt.cmdheight = 0
opt.colorcolumn = { "80", "120" }
opt.scrolloff = 15
opt.cursorline = true
opt.mouse = "a"
opt.laststatus = 3

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.number = true
opt.numberwidth = 2

opt.undofile = true
opt.whichwrap:append("<>[]hl")

-- opt.wrap = false
opt.breakindent = true
opt.linebreak = true

-- disable nvim intro
opt.shortmess:append("sI")

opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

-- opt.completeopt = "menuone,noselect"
opt.completeopt = "menu,menuone"

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
