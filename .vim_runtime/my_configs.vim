" Autocomplete file header
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
func SetTitle() 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

    elseif &filetype == 'mkd'
        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: ") 
		call append(line(".")+2, "	> Mail: ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
endfunc 
autocmd BufNewFile * normal G

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" set auto lint
let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
let g:pymode_rope = 0
" use python as default setting 
let g:pymode_python = 'python'

" Skip syntastic check when saving
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" map <leader>c -> :SyntasticCheck
nmap <leader>c <Esc>:SyntasticCheck<CR>
" map <leader>q -> :lclose
nmap <leader>q <Esc>:lclose<CR>
" map <leader>e -> :Errors
nmap <leader>e <Esc>:Errors<CR>
" map <leader>r -> :RustFmt
nmap <leader>r <Esc>:RustFmt<CR>
" map <leader>t -> :TagbarToggle
nmap <leader>t <Esc>:TagbarToggle<CR>

" map <leader>l -> :NERDTreeToggle
nmap <leader>l <Esc>:NERDTreeToggle<CR>

" Highlight current line
set cursorline

" turn hybrid line numbers on
set number relativenumber
set nu rnu
