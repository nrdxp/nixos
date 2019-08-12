nnoremap <C-p> :GFiles<Enter>
nnoremap <C-M-p> :FZF<Enter>
nnoremap <C-M-r> :Files /<Enter>
nnoremap <C-M-e> :Files ~<Enter>


" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
