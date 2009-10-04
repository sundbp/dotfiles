" Patrik Sundberg's .vimrc
" 

set nocompatible        " We don't want vi compatibility.

filetype on             " Automatically detect file types.
filetype indent on
filetype plugin on 

syntax enable
set cf                  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256         " Number of things to remember in history.
set autowrite           " Writes on make/shell commands
set ruler               " Ruler on
set nu                  " Line numbers on
set nowrap              " Line wrapping off
set timeoutlen=250      " Time to wait after ESC (default causes an annoying delay)
colorscheme vividchalk  " Uncomment this to set a default theme

" Formatting (some of these are for coding in C and C++)
set ts=2                " Tabs are 2 spaces
set bs=2                " Backspace over everything in insert mode
set shiftwidth=2        " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
 
" Visual
set showmatch           " Show matching brackets.
set mat=5               " Bracket blinking.
set nolist
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell        " No blinking .
set noerrorbells        " No noise.
set laststatus=2        " Always show status line.
 
" gvim specific
set mousehide           " Hide mouse after chars typed
set mouse=a             " Mouse in all modes

" NERDTree key
nmap <silent> <Leader>p :NERDTreeToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer and use relative paths
nnoremap <C-B> :BufExplorer<cr>
let g:bufExplorerShowRelativePath=1

"map to fuzzy finder text mate stylez
nnoremap <C-F> :FuzzyFinderTextMate<CR>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu gui=bold guibg=#CECECE guifg=#444444

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplUseSingleClick = 1

" Add recently accessed projects menu (project plugin)
set viminfo^=!

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
