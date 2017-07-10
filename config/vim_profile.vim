" Copyright © 2017 Paul Viallard <paul.viallard@gmail.com>
" This work is free. You can redistribute it and/or modify it under the
" terms of the Do What The Fuck You Want To Public License, Version 2,
" as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

set nocompatible
filetype off
execute pathogen#infect()
execute pathogen#helptags()
filetype plugin indent on
syntax on

set langmenu=none
set mouse=a
set ttymouse=xterm2
set ruler
set nu
set noswapfile

" Tab rule
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

" Indentation
set backspace=indent,eol,start
set smartindent
set autoindent 


" Copy/Paste/Undo
" Undo
nnoremap <C-z> <nop>
vnoremap <C-z> <nop>
inoremap <C-z> <nop>

nnoremap <C-z> u
vnoremap <C-z> u
inoremap <C-z> <C-O>u

" Redo
nnoremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Copy
vnoremap <C-c> y

" Paste
nnoremap <C-v> p
inoremap <C-v> <ESC>pi

" Cut
vnoremap <C-x> x

" Backspace
vnoremap <BS> x
nnoremap <BS> x

" Clipboard
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Colors
colorscheme paulviallard

" NERDTree 
autocmd VimEnter * NERDTree
autocmd WinEnter * call ManageNERDTree()
let g:NERDTreeWinPos = "left"

function ManageNERDTree()
  if winnr('$') == 1 && @% == t:NERDTreeBufName 
    quit
  endif
  if bufwinnr(t:NERDTreeBufName) == -1
    NERDTree
  endif 
endfunction

" NERDCommenter
function PutCommentTitle()
  let size = 50
  let c = 1
  let s = ""
  let caracter = '='
  while c <= size
    s .= caracter
    let c += 1
  endwhile
  put =@s  
  call NERDComment(1, 'sexy')
  put =@s
  call NERDComment(1, 'sexy')
endfunction

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

inoremap <C-t> <ESC>:call NERDComment(0, 'toggle')<CR>
nnoremap <C-t> :call NERDComment(1, 'toggle')<CR>
vnoremap <C-t> :call NERDComment(0, 'toggle')<CR>

" Statusbar
if has("statusline")
  set laststatus=2
  set statusline =%F
  set statusline +=\ \ 
  set statusline +=%l:%c
  set statusline +=\ \ 
  set statusline +=%y%m%r%{fugitive#statusline()}
endif