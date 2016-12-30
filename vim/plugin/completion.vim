if executable('npm') && executable('tern')
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]

    let g:tern_request_timeout = 1
    let g:tern_show_signature_in_pum = 1
endif

let g:echodoc_enable_at_startup	= 1

if has('nvim')
    " http://vi.stackexchange.com/questions/9468/cant-get-deoplete-plugin-working-in-neovim
    let g:deoplete#enable_at_startup  = 1
    let g:deoplete#file#enable_buffer_path = 1

    set splitbelow
    " set completeopt+=noselect
    " set completeopt+=noinsert

    " Close preview window after completion is done.
    autocmd CompleteDone * pclose!


    let g:deoplete#sources={}
    let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ternjs']
endif

