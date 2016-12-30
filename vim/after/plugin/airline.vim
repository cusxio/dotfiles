let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#ale#enabled = 1

" let g:airline_section_c = '%t'
let g:airline_section_z = '%3p%%'
let g:airline_section_y = g:airline_symbols.linenr . '%4l/%L ⋅%2c'

let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 80,
    \ 'x': 60,
    \ 'y': 45,
    \ 'z': 45,
    \ 'warning': 60,
    \ 'error': 60,
    \ }

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'β'

let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#fnamemod = ':p:t'