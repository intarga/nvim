" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ingrid Abraham <intarga@protonmail.com>
" Last Change:	2021 Jan 28

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "brint"

highlight Comment	   ctermfg=blue					 cterm=none   guifg=#808080
highlight Constant	   ctermfg=red			         cterm=none   guifg=#00ffff		   	      gui=none
highlight Identifier   ctermfg=cyan						          guifg=#00c0c0
highlight Statement    ctermfg=red			         cterm=bold   guifg=#c0c000				  gui=bold

highlight PreProc	   ctermfg=10						          guifg=#00ff00
highlight Type		   ctermfg=green						      guifg=#00c000
highlight Special	   ctermfg=magenta						      guifg=#0000ff

highlight Error					       ctermbg=9							    guibg=#ff0000
highlight Todo		   ctermfg=4	   ctermbg=3			      guifg=#000080 guibg=#c0c000

highlight Directory    ctermfg=2						          guifg=#00c000
highlight StatusLine   ctermfg=white   ctermbg=black cterm=bold   guifg=#ffff00 guibg=#0000ff gui=none
highlight Normal									              guifg=#ffffff guibg=#000000
highlight Search				       ctermbg=3							    guibg=#c0c000

highlight LineNr       ctermfg=grey
highlight CursorLineNr ctermfg=red                   cterm=bold

highlight Pmenu        ctermfg=4       ctermbg=0                                guibg=grey
highlight PmenuSel     ctermfg=1       ctermbg=0                  guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar    ctermfg=blue    ctermbg=grey                             guibg=#d6d6d6

highlight SignColumn                   ctermbg=black

highlight Visual                       ctermbg=grey
