if !has('nvim')
    " https://neovim.io/doc/user/vim_diff.html#nvim-defaults
    set nocompatible
    set encoding=utf-8

    " Indentation
    set autoindent
    set smartindent

    " Normal backspace behaviour
    set backspace=indent,eol,start

    " Always display status line
    set laststatus=2

    " Enable a faster terminal
    set ttyfast

    " Improve scrolling performance
    set lazyredraw

    " Allows for command line completetion, e.g.: :color <Tab>
    set wildmenu

    " Read file again when the file is changed outside of VIM
    set autoread

    " Enable the use of mouse in all modes
    set mouse=a

endif

if has('nvim')
    " Use line cursor in insert mode
    " Use block cursor in other modes
    " https://github.com/neovim/neovim/issues/4867
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

    " Provider
    " https://neovim.io/doc/user/provider.html
    " Python 2
    let s:pyenv_python2 = glob(expand('$PYENV_ROOT/versions/neovim2/bin/python'))
    if !empty(s:pyenv_python2)
        let g:python_host_prog = s:pyenv_python2
    else
        let g:loaded_python_provider = 1
    endif

    " Python 3
    let s:pyenv_python3 = glob(expand('$PYENV_ROOT/versions/neovim3/bin/python'))
    if !empty(s:pyenv_python3)
        let g:python3_host_prog = s:pyenv_python3
    else
        let g:loaded_python3_provider = 1
    endif
endif

if has('autocmd')
    " Indent according to previous line
    filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
    " Enable syntax highlighting
    syntax enable
endif

" Tab to Spaces
set expandtab

" 4 Space Tab
set tabstop=4

" Use 4 spaces for indentation
set shiftwidth=4

" >> indents to next multiple of 'shiftwidth'.
set shiftround

" Show line numbers in gutter
set number

" Use relative numbers in gutter
set relativenumber

" Disable beeping
set visualbell

" Disable flashing
set noerrorbells

" Don't display VIM's mode since it is already shown in the statusline
set noshowmode

" Shows line and column number
set ruler

" Inherit terminal title from VIM
set title

" Show additional info about the command currently used
set showcmd

" A better command line completion
set wildmode=full

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces

" Improve <Esc> key behaviour
" https://github.com/neovim/neovim/issues/2017#issuecomment-170643914
set ttimeout
set ttimeoutlen=100

" Highlight search results
set hlsearch

" Make search case insensitive
set ignorecase

" Uppercase pattern to match uppercase results
set smartcase

" Start searching ASAP
set incsearch

" Change width size of number gutter
" set numberwidth=3

" Highlight currentline
" https://github.com/mhinz/vim-galore#smarter-cursorline
set cursorline " needed to enable cursorline on startup
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Show eol/ trailing white spaces/ tabs
set list
set listchars=
" set listchars+=tab:▸\
set listchars+=trail:·
" set listchars+=eol:¬
" set listchars+=extends:»
" set listchars+=precedes:«
" set listchars+=nbsp:⣿
"
" Fold Settings
" set foldcolumn=2
" hi FoldColumn guibg=#1d2021

" Use system clip
set clipboard=unnamedplus

" Faster git-gutter update
set updatetime=250

" Allow hidden buffers
set hidden
