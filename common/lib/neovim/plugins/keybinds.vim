" Map jj to ESC for Normal mode
inoremap jj <Esc>

" Move on to right in input mode
imap jl <c-o>l
imap jL <c-o>A

" Moving between buffers incrementally
nnoremap <silent> <M-n> :bnext<CR>
nnoremap <silent> <M-p> :bp<CR>

" provide hjkl movements in Insert mode via the <Alt> modifier key
noremap! <A-h> <Left>
noremap! <A-j> <Down>
noremap! <A-k> <Up>
noremap! <A-l> <Right>

"Normal mode commands for insert mode holding alt
inoremap <A-b> <C-o>b
inoremap <A-w> <C-o>w
inoremap <A-W> <C-o>W
inoremap <A-B> <C-o>B
inoremap <A-e> <C-o>e
inoremap <A-E> <C-o>E

" Same thing but for Command mode
cnoremap <expr> <A-b> &cedit. 'b' .'<C-c>'
cnoremap <expr> <A-w> &cedit. 'w' .'<C-c>'

" Turn off Search Highlighting
nnoremap <silent><leader>n :noh<CR>

"Save and quit shortcuts
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-q> :q<CR>

" Clear Buffer
nnoremap <silent> <M-q> :Bdelete<CR>
nnoremap <silent> <M-C-q> :bufdo Bdelete<CR>

" Resize/reset splits using +-
nnoremap <M--> <C-W>-
nnoremap <M-+> <C-W>+
nnoremap <M-=> <C-W>=

" move lines up and down; thanks to http://stackoverflow.com/a/741819
function! s:swap_lines(n1, n2)
  let line1 = getline(a:n1)
  let line2 = getline(a:n2)
  call setline(a:n1, line2)
  call setline(a:n2, line1)
endfunction

function! s:swap_up()
  let n = line('.')
  if n == 1
    return
  endif

  call s:swap_lines(n, n - 1)
  exec n - 1
endfunction

function! s:swap_down()
  let n = line('.')
  if n == line('$')
    return
  endif

  call s:swap_lines(n, n + 1)
  exec n + 1
endfunction

noremap <silent> <M-k> :call <SID>swap_up()<CR>
noremap <silent> <M-j> :call <SID>swap_down()<CR>
