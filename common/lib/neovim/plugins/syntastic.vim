let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_rust_checkers = ['rustc']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['css'] }

nnoremap <F5> :SyntasticToggleMode<CR>
