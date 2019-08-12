" Use deoplete.
let g:deoplete#enable_at_startup = 1

" neocomplete like
set completeopt+=noinsert

" deoplete.nvim recommend
set completeopt+=noselect

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
      \ : (neosnippet#expandable_or_jumpable()
      \? "\<Plug>(neosnippet_expand_or_jump)"
      \ : (<SID>is_whitespace() ? "\<Tab>"
      \ : deoplete#mappings#manual_complete()))

smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
      \ : (neosnippet#expandable_or_jumpable()
      \? "\<Plug>(neosnippet_expand_or_jump)"
      \ : (<SID>is_whitespace() ? "\<Tab>"
      \ : deoplete#mappings#manual_complete()))

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace() "{{{
  let col = col('.') - 1
  return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" NeoSnippet config
imap <S-Tab>     <Plug>(neosnippet_expand_or_jump)
smap <S-Tab>     <Plug>(neosnippet_expand_or_jump)
xmap <S-Tab>     <Plug>(neosnippet_expand_target)
