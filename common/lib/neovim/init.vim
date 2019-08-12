" Author: Timothy DeHerrera <tim.de9@gmail.com>

" --- GENERAL SETTINGS ---

" Gotta be first (vim only)
set nocompatible

" set color column for 80 chars
set colorcolumn=80

" X11 clipboard access
set clipboard+=unnamedplus

" truecolor
if has('termguicolors')
  set termguicolors
endif

" indent wrapped lines same amount as the previous line
set breakindent

" Make backspace work over \n and insert start
set backspace=indent,eol,start

" line numbers
set number

" show the current command in bottom of screen
set showcmd

" show search matches while typing
set incsearch

" highlight all search matches
set hlsearch

" enable mouse for all modes
set mouse=a

" show existing tab with 2 spaces width
set tabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Convert tabs to spaces
set expandtab

" turn off filetype detection before sourcing plugins
filetype off
