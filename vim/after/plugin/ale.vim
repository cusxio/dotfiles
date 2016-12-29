let g:ale_lint_delay = 50
let g:ale_sign_column_always = 1
let g:ale_sign_error = '»'
let g:ale_sign_warning = '»'

let g:ale_echo_msg_format = '[%linter%] %s '

hi ALEErrorSign ctermbg=None guifg=red
hi ALEWarningSign ctermbg=None guifg=orange

augroup aleUpdate
    autocmd!
    autocmd User ALELint call lightline#update()
augroup END