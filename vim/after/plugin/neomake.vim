" Different view for the errors
" let g:neomake_open_list=2

" let g:neomake_error_sign    = { 'text': '☻', 'texthl': 'NeomakeErrorSign' }
" let g:neomake_warning_sign  = { 'text': '☻', 'texthl': 'NeomakeWarningSign' }
" let g:neomake_message_sign  = { 'text': '☻', 'texthl': 'NeomakeMessageSign' }
" let g:neomake_info_sign     = { 'text': '☻', 'texthl': 'NeomakeInfoSign' }
"
" " eslint
" if findfile('.eslintrc', '.;') !=# '' ||
"     \ findfile('.eslintrc.js', '.;') !=# '' ||
"     \ findfile('.eslintrc.yaml', '.;') !=# '' ||
"     \ findfile('.eslintrc.yml', '.;') !=# '' ||
"     \ findfile('.eslintrc.json', '.;') !=# ''
"     let g:neomake_javascript_enabled_makers = ['eslint']
"     let g:neomake_jsx_enabled_makers = g:neomake_javascript_enabled_makers
"
"     let g:neomake_javascript_eslint_exe = nrun#Which('eslint')
"     let g:neomake_jsx_eslint_exe = g:neomake_javascript_eslint_exe
" endif
"
" autocmd! BufWinEnter,BufWritePost * Neomake
