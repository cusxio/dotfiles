-- https://github.com/nvim-mini/mini.basics/blob/b2c25615ebaf3da0ebcc25eefd5510c02126ffac/lua/mini/basics.lua

vim.g.mapleader = " "

local o = vim.o

-- General
-- o.undofile = true -- Enable persistent undo (see also `:h undodir`)

-- o.backup = false -- Don't store backup while overwriting the file
-- o.writebackup = false -- Don't store backup while overwriting the file

-- o.mouse = "a" -- Enable mouse for all available modes

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Appearance
-- o.breakindent = true -- Indent wrapped lines to match line start
o.cursorline = true -- Highlight current line
-- o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.number = true -- Show line numbers
o.splitbelow = true -- Horizontal splits will be below
o.splitright = true -- Vertical splits will be to the right

o.cmdheight = 0
o.scrolloff = 7

-- o.ruler = false -- Don't show cursor position in command line
-- o.showmode = false -- Don't show mode in command line
-- o.wrap = false -- Display long lines as just one line

o.signcolumn = "yes" -- Always show sign column (otherwise it will shift text)
-- o.fillchars = "eob: " -- Don't show `~` outside of buffer

-- Editing
o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase = true -- Don't ignore case when searching if pattern has upper case
-- o.smartindent = true -- Make indenting smart

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.shiftround = true

o.clipboard = "unnamedplus"
-- o.completeopt = "menuone,noselect" -- Customize completions
-- o.virtualedit = "block" -- Allow going past the end of line in visual block mode
-- o.formatoptions = "qjl1" -- Don't autoformat comments

-- Neovim version dependent
-- opt.shortmess:append("WcC") -- Reduce command line messages
-- o.splitkeep = "screen" -- Reduce scroll during window split

-- o.termguicolors = true -- Enable gui colors
o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

local gr = vim.api.nvim_create_augroup("MiniBasicsAutocommands", {})
local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(
    event,
    { group = gr, pattern = pattern, callback = callback, desc = desc }
  )
end

au(
  "ModeChanged",
  -- Show relative numbers only when they matter (linewise and blockwise
  -- selection) and 'number' is set (avoids horizontal flickering)
  "*:[V\x16]*",
  function()
    vim.wo.relativenumber = vim.wo.number
  end,
  "Show relative line numbers"
)
au(
  "ModeChanged",
  "[V\x16]*:*",
  -- Hide relative numbers when neither linewise/blockwise mode is on
  function()
    vim.wo.relativenumber = string.find(vim.fn.mode(), "^[V\22]") ~= nil
  end,
  "Hide relative line numbers"
)

vim.g.lazy_file_events = { "BufReadPost", "BufNewFile" }
