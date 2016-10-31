" Leader is <space>
let mapleader = ' '
nnoremap <space> <nop>

" Disable CTRL-A  in tmux
if !empty($TMUX)
    nnoremap <C-a> <nop>
    nnoremap <Leader><C-a> <C-a>
endif

" jk | Escaping
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Save
" inoremap <C-s>     <C-O>:update<cr>
inoremap <C-s>     <Esc>:update<cr>
nnoremap <C-s>     :update<cr>

" Disable all arrow keys
" for learning purposes
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Error mnemonic (Neomake uses location list)
nnoremap ]e :lnext<cr>zz
nnoremap [e :lprev<cr>zz

if has('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

" From vim-sensible
"
" Check out:
" haya14busa/incsearch.vim
" when nvim hits 0.2
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
