local api = vim.api
local o = vim.o

api.nvim_set_keymap('i', 'jk', '<Esc>', {noremap = true, silent = true})

api.nvim_exec(
  [[
  set expandtab
  set shiftwidth=2
  set tabstop=2

  set number
  set cursorline
  set scrolloff=10

  set hidden

  set splitbelow
  set splitright

  set clipboard=unnamed

  let g:sonokai_cursor = 'red'
  let g:sonokai_transparent_background = 1
  let g:sonokai_style = 'shusia'
  colorscheme sonokai
  ]], ''
)

-- -- Tab to Spaces
-- opt.expandtab = true

-- -- 2 Space Tab
-- opt.tabstop = 2

-- -- Use 2 spaces for indentation
-- opt.shiftwidth = 4

-- -- Show line numbers in gutter
-- opt.number = true

-- -- Use relative numbers in gutter
-- opt.relativenumber = true

o.termguicolors = true

require 'plugins'
