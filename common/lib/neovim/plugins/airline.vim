" Always show statusbar
set laststatus=2

" Enable Powerline Symbols
let g:airline_powerline_fonts=1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled=1

" Don't overwrite tmux line conf loaded from .tmux.conf
let g:airline#extensions#tmuxline#enabled=0
