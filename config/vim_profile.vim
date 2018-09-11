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
if !has('nvim')
  set ttymouse=xterm2
endif
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

" Split rules
set splitbelow
set splitright

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

" Cursor move
nnoremap <S-TAB> <C-w>w
vnoremap <S-TAB> <C-w>w
inoremap <S-TAB> <C-w>w

" Window move
nnoremap <S-LEFT> <C-w>H
vnoremap <S-LEFT> <C-w>H
inoremap <S-LEFT> <C-w>H

nnoremap <S-RIGHT> <C-w>L
vnoremap <S-RIGHT> <C-w>L
inoremap <S-RIGHT> <C-w>L

nnoremap <S-UP> <C-w>K
vnoremap <S-UP> <C-w>K
inoremap <S-UP> <C-w>K

nnoremap <S-DOWN> <C-w>J
vnoremap <S-DOWN> <C-w>J
inoremap <S-DOWN> <C-w>J

" Completion
autocmd CompleteDone * pclose
set complete=.,t
set omnifunc=syntaxcomplete#Complete

" Clipboard
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

" Colors
colorscheme paulviallard

" NERDTree 
autocmd VimEnter * call ManageNERDTreeEnter()
autocmd WinEnter * call ManageNERDTree()
let g:NERDTreeWinPos = "left"

function ManageNERDTreeEnter()
  if &filetype != "man"
    NERDTree
    :wincmd l
  endif
endfunction

function ManageNERDTree()
  if winnr('$') == 1 && @% == t:NERDTreeBufName 
    quit
  endif
  if (!exists("t:NERDTreeBufName")) || bufwinnr(t:NERDTreeBufName) == -1
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

" SuperTab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ['&omnifunc:<c-x><c-o>', '&completefunc:<c-x><c-u>']
autocmd FileType * if &omnifunc != '' | call SuperTabChain(&omnifunc, "<c-p>") | endif

" Nvim-R
let R_assign = 0
let R_in_buffer = 0
let R_nvimpager = "horizontal"
autocmd VimEnter * call ManageNvimREnter()
function ManageNvimREnter()
  if &filetype == "r"
    vmap <C-r> <Plug>RDSendSelection
    nmap <C-r> <Plug>RDSendLine
    imap <M-SPACE> <C-X><C-A>
    command RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf 
    :RStart
  endif 
endfunction

" Vim-Latex
let g:Tex_FoldedSections = ""
let g:Tex_FoldedEnvironments = ""
let g:Tex_FoldedMisc = ""
let g:Imap_UsePlaceHolders = 0
let g:Tex_GotoError = 0
let g:Tex_ShowErrorContext = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode -file-line-error-style $*'
autocmd VimEnter * call ManageVimLatexEnter()
function ManageVimLatexEnter()
  if &filetype == "tex"
    nnoremap <C-r> :silent! call Tex_RunLaTeX()<CR> 
    inoremap <C-r> <Esc>:silent! call Tex_RunLaTeX()<CR><Home>i
    vnoremap <C-r> <Esc>:silent! call Tex_RunLaTeX()<CR>
  endif
endfunction

" python-mode
if has("python3")
  let g:pymode_python = 'python3'
endif
let g:pymode_run = 1
let g:pymode_run_bind = '<C-r>'
let g:pymode_doc = 1
let g:pymode_doc_bind = '<C-d>'
let g:pymode_options_colorcolumn = 0
let g:pymode_folding = 0

" vim-markdown
let g:vim_markdown_folding_disabled = 1 
autocmd VimEnter * call ManageVimMarkdownEnter()
function ManageVimMarkdownEnter()
  if &filetype == "markdown"
    nnoremap <C-r> :! $HOME/.vim/bundle/vim-markdown/markdown.pl % > %:r.html<CR> 
    inoremap <C-r> <Esc>:! $HOME/.vim/bundle/vim-markdown/markdown.pl % > %:r.html<CR><Home>i
    vnoremap <C-r> <Esc>:! $HOME/.vim/bundle/vim-markdown/markdown.pl % > %:r.html<CR>
  endif
endfunction


" Statusbar
if has("statusline")
  set laststatus=2
  set statusline =%F
  set statusline +=\ \ 
  set statusline +=%l:%c
  set statusline +=\ \ 
  set statusline +=%y%m%r%{fugitive#statusline()}
endif
