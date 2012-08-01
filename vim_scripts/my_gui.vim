" UI settings
if has("gui_running")
  let g:solarized_termcolors=256
else
  let g:solarized_termcolors=16
endif
set background=dark
colorscheme solarized

"colorscheme molokai

set guifont=Monaco\ for\ Powerline\ 11
"set guifont=Menlo\ for\ Powerline\ 11
"set guifont=Inconsolata-dz\ for\ Powerline\ 11
"set guifont=Mensch\ for\ Powerline\ 11
"set guifont=Monospace\ 11
"
" show a 120 char width market
set cc=120
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" no menubar
set guioptions-=T

