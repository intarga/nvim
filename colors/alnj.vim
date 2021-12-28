" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Ingrid Abraham <intarga@protonmail.com>
" Last Change:	2021 May 24

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "alnj"

" editor settings

highlight Normal									        guifg=#ffffff guibg=#000000

highlight LineNr       ctermfg=grey
highlight CursorLineNr ctermfg=1                 cterm=bold
highlight StatusLine   ctermfg=9    ctermbg=NONE cterm=bold guifg=#ffff00 guibg=#0000ff gui=none
highlight SignColumn                ctermbg=NONE

highlight Pmenu        ctermfg=4    ctermbg=0                             guibg=grey
highlight PmenuSel     ctermfg=1    ctermbg=0               guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar    ctermfg=4    ctermbg=grey                          guibg=#d6d6d6

highlight Visual                    ctermbg=0
highlight Search				    ctermbg=4							  guibg=#c0c000
highlight Todo		   ctermfg=1	ctermbg=NONE			guifg=#000080 guibg=#c0c000

" language constructs

highlight MatchParen   ctermfg=1    ctermbg=0    cterm=bold

highlight Comment	   ctermfg=4				 cterm=none guifg=#808080
highlight Constant	   ctermfg=1			     cterm=none guifg=#00ffff		   	    gui=none

highlight Identifier   ctermfg=14				 cterm=none guifg=#00c0c0
highlight Function     ctermfg=6                 cterm=bold
"highlight Structure                              cterm=bold
"highlight StorageClass                           cterm=bold
"highlight Typedef                                cterm=bold

highlight Statement    ctermfg=1			     cterm=bold guifg=#c0c000			    gui=bold

highlight PreProc	   ctermfg=10						    guifg=#00ff00
highlight Type		   ctermfg=2						    guifg=#00c000
highlight Special	   ctermfg=5						    guifg=#0000ff

highlight Error					    ctermbg=9							  guibg=#ff0000

highlight Directory    ctermfg=2						    guifg=#00c000

highlight Title        ctermfg=1                 cterm=bold

" LSP

highlight LspDiagnosticsSignError       ctermfg=1 cterm=bold
highlight LspDiagnosticsSignWarning     ctermfg=1 cterm=bold
highlight LspDiagnosticsSignInformation ctermfg=1 cterm=bold
highlight LspDiagnosticsSignHint        ctermfg=1 cterm=bold
