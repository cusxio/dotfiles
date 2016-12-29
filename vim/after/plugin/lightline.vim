function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ' '
            let branch = fugitive#head()
            return branch !=# '' ? mark.branch : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineReadonly()
    return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! s:count(index)
    let l:buf = bufnr('%')
    let l:count = ale#statusline#Count(l:buf)
    if type(l:count) ==# type(0)
        let l:count = 0
    else
        let l:count = l:count[a:index]
    endif

    return l:count
endfunction

function! LightlineAleError()
    let l:count = s:count(0)
    return l:count ? 'E:' . l:count : ''
endfunction

function! LightlineAleWarning()
    let l:count = s:count(1)
    return l:count ? 'W:' . l:count : ''
endfunction

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'enable' :{
    \   'tabline': 0,
    \   'statusline': 1
    \ },
    \ 'separator': {
    \   'left': '',
    \   'right': ''
    \ },
    \ 'subseparator': {
    \   'left': '',
    \   'right': ''
    \ },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], ['fugitive'], ['filename'] ],
    \   'right': [ ['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype' ], ['alewarning', 'aleerror'] ]
    \ },
    \ 'component_expand': {
    \   'alewarning': 'LightlineAleWarning',
    \   'aleerror': 'LightlineAleError'
    \ },
    \ 'component_type': {
    \   'aleerror': 'error',
    \   'alewarning': 'warning'
    \ },
    \ 'component_function': {
    \   'mode': 'LightlineMode',
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'readonly': 'LightlineReadonly',
    \   'modified': 'LightlineModified',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \ },
    \ }

