-- https://github.com/nvim-mini/mini.basics/blob/b2c25615ebaf3da0ebcc25eefd5510c02126ffac/lua/mini/basics.lua

vim.g.mapleader = " "

local o, opt = vim.o, vim.opt

-- stylua: ignore start
-- General
-- o.undofile    = true -- Enable persistent undo (see also `:h undodir`)
o.undofile       = true
o.undodir        = vim.fn.stdpath("state") .. "/undo"
o.undolevels     = 10000

-- o.backup      = false -- Don't store backup while overwriting the file
-- o.writebackup = false -- Don't store backup while overwriting the file

-- o.mouse       = "a" -- Enable mouse for all available modes

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Appearance
-- o.breakindent = true -- Indent wrapped lines to match line start
o.cursorline     = true -- Highlight current line
-- o.linebreak   = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.number         = true -- Show line numbers
o.splitbelow     = true -- Horizontal splits will be below
o.splitright     = true -- Vertical splits will be to the right

o.list           = true
opt.listchars    = { space = '·', trail = '·' }

o.cmdheight      = 0
o.scrolloff      = 7

opt.laststatus   = 3

-- o.ruler       = false -- Don't show cursor position in command line
-- o.showmode    = false -- Don't show mode in command line
-- o.wrap        = false -- Display long lines as just one line

o.signcolumn     = "yes" -- Always show sign column (otherwise it will shift text)
-- o.fillchars   = "eob: " -- Don't show `~` outside of buffer

-- Editing
o.ignorecase     = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch      = true -- Show search results while typing
o.infercase      = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase      = true -- Don't ignore case when searching if pattern has upper case
-- o.smartindent = true -- Make indenting smart

o.expandtab      = true
o.tabstop        = 2
o.shiftwidth     = 2
o.shiftround     = true

o.clipboard      = "unnamedplus"

opt.shortmess:append("WF")

o.statuscolumn   = [[%!v:lua.require'snacks.statuscolumn'.get()]]
-- stylua: ignore end

vim.g.lazy_file_events = { "BufReadPost", "BufNewFile" }

vim.filetype.add({
  pattern = {
    [".*/kitty/.+%.conf"] = "bash",
    [".*/ghostty/config"] = "config",
    [".*/git/config"] = "ini",
    ["%.env%.[%w_.-]+"] = "sh",
    ["uv.lock"] = "toml",
  },
})
