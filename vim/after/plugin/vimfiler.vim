" disable vimfiler default keymappings
let g:vimfiler_no_default_key_mappings = 1

let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']

" Use vimfiler as default file manager. Disables netrw.
let g:vimfiler_as_default_explorer = 1

let g:vimfiler_tree_indentation = 1

" Use trashbox
" requires "rmtrash", i.e. brew install rmtrash
let g:unite_kind_file_use_trashbox = 1

" horizontal: vimfiler buffer in horizontal
" vertical: vimfiler buffer in vertical
" force_quit: exit the vimfiler buffer after firing an action
" call vimfiler#custom#profile('vimfiler', 'context', {
"     \ 'explorer' : 1,
"     \ 'toggle' : 1,
"     \ 'columns' : 'type:size',
"     \ 'explorer_columns' : 'type:size',
"     \ 'status' : 1,
"     \ 'safe' : 0,
"     \ 'force_quit': 1,
"     \ 'vertical': 1,
"     \ 'split' : 1
"     \ })

call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0,
    \ 'auto_expand' : 1,
    \ 'parent' : 0,
    \ })

nnoremap <Space>v   :<C-u>VimFiler -invisible<CR>
nnoremap <F2> :VimFiler -find<CR>

augroup oxygenVimFilerKeymap
    autocmd FileType vimfiler nmap <silent> <buffer>        c        <Plug>(vimfiler_copy_file)
    autocmd FileType vimfiler nmap <silent> <buffer>        m        <Plug>(vimfiler_move_file)
    autocmd FileType vimfiler nmap <silent> <buffer>        d        <Plug>(vimfiler_delete_file)
    autocmd FileType vimfiler nmap <silent> <buffer>        N        <Plug>(vimfiler_new_file)
    autocmd FileType vimfiler nmap <silent> <buffer>        D        <Plug>(vimfiler_make_directory)
    autocmd FileType vimfiler nmap <silent> <buffer>        r        <Plug>(vimfiler_rename_file)

    autocmd FileType vimfiler nmap <silent> <buffer>        ~        <Plug>(vimfiler_switch_to_home_directory)
    autocmd FileType vimfiler nmap <silent> <buffer>        \       <Plug>(vimfiler_switch_to_root_directory)
    autocmd FileType vimfiler nmap <silent> <buffer>        %        <Plug>(vimfiler_switch_to_project_directory)
    autocmd FileType vimfiler nmap <silent> <buffer>        u        <Plug>(vimfiler_switch_to_parent_directory)

    autocmd FileType vimfiler nmap <silent> <buffer>      <Enter>    <Plug>(vimfiler_cd_or_edit)
    autocmd FileType vimfiler nmap <silent> <buffer>        o        <Plug>(vimfiler_expand_or_edit)

    autocmd FileType vimfiler nmap <silent> <buffer>        T        <Plug>(vimfiler_expand_tree_recursive)
    autocmd FileType vimfiler nmap <silent> <buffer>        t        <Plug>(vimfiler_expand_tree)

    autocmd FileType vimfiler nmap <silent> <buffer>        <C-p>    <Plug>(vimfiler_find)
    autocmd FileType vimfiler nmap <silent> <buffer>        l        <Plug>(vimfiler_redraw_screen)
    autocmd FileType vimfiler nmap <silent> <buffer>        gg       <Plug>(vimfiler_cursor_top)
    autocmd FileType vimfiler nmap <silent> <buffer>        .        <Plug>(vimfiler_toggle_visible_ignore_files)
    autocmd FileType vimfiler vmap <silent> <buffer>        x        <Plug>(vimfiler_toggle_mark_selected_lines)
    autocmd FileType vimfiler nmap <silent> <buffer>        x        <Plug>(vimfiler_toggle_mark_current_line)

    autocmd FileType vimfiler nmap <silent> <buffer>        gr        <Plug>(vimfiler_grep)
    autocmd FileType vimfiler nmap <silent> <buffer>        gf        <Plug>(vimfiler_find)

    autocmd FileType vimfiler nmap <silent> <buffer>   <2-LeftMouse>  <Plug>(vimfiler_double_click)
    autocmd FileType vimfiler nmap <silent> <buffer>   <RightMouse>   <Plug>(vimfiler_execute_external_filer)

    autocmd FileType vimfiler nmap <silent> <buffer>        q        <Plug>(vimfiler_hide)
    autocmd FileType vimfiler nmap <silent> <buffer>        Q        <Plug>(vimfiler_exit)
    autocmd FileType vimfiler nmap <silent> <buffer>        -        <Plug>(vimfiler_close)

    autocmd FileType vimfiler nmap <silent> <buffer> <expr> v        vimfiler#do_switch_action('vsplit')
    autocmd FileType vimfiler nmap <silent> <buffer> <expr> s        vimfiler#do_switch_action('split')
augroup END

