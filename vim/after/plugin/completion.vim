if executable('npm') && executable('tern')
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]

    let g:tern_request_timeout = 1
    let g:tern_show_signature_in_pum = 1
endif

if has('nvim')
    call deoplete#enable()
    let g:deoplete#file#enable_buffer_path = 1
endif
