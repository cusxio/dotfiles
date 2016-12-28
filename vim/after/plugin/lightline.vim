function! FileSize()
    let bytes = getfsize(expand('%:p'))
    if (bytes >= 1024)
        let kbytes = bytes / 1024
    endif
    if (exists('kbytes') && kbytes >= 1000)
        let mbytes = kbytes / 1000
    endif

    if bytes <= 0
        return '[empty file] '
    endif

    if (exists('mbytes'))
        return mbytes . 'MB '
    elseif (exists('kbytes'))
        return kbytes . 'KB '
    else
        return bytes . 'B '
    endif
endfunction

function! ReadOnly()
    if &readonly || !&modifiable
        return ''
    else
        return ''
endfunction

function! Modified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! GitInfo()
    let git = fugitive#head()
    if git != ''
        return ' '.fugitive#head()
    else
        return ''
endfunction

function! Filename()
  return ('' != ReadOnly() ? ReadOnly() . ' ' : '') .
       \ expand('%') =~? 'term://.*\.fzf/bin/fzf' ? '' :
       \ ('' != expand('%:p:~') ? expand('%:p:~') : '[No Name]') .
       \ ('' != Modified() ? ' ' . Modified() : '')
endfunction

function! LightlineALE()
    return '%{ALEGetStatusLine()}'
endfunction

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
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
    \   'left': [ [ 'mode' ], [ 'spell', 'paste' ], ['fugitive'], ['filename'] ],
    \   'right': [ ['percent', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype', 'filesize'], ['ale'] ]
    \ },
    \ 'component': {
    \   'filename': '%<%f'
    \ },
    \ 'component_function': {
    \   'readonly': 'ReadOnly',
    \   'modified': 'Modified',
    \   'fugitive': 'GitInfo',
    \   'filesize': 'FileSize'
    \ },
    \ 'component_expand': {
    \   'ale': 'LightlineALE'
    \ },
    \ 'component_type': {
    \   'paste': 'warning',
    \   'spell': 'warning',
    \ },
    \ }

