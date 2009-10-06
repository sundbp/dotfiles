" Font
set guifont=Monaco:h15.00

" No audible bell
set vb

" No toolbar
"set guioptions-=T

" Use console dialogs
set guioptions+=c

" window size
set lines=40
set columns=80

" Local config
if filereadable(".gvimrc.local")
  source .gvimrc.local
endif

