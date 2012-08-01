" Settings and mappings relating to CtrlP

" make sure we can search ctags
let g:ctrlp_extensions = ['tag', 'buffer_tag']

nmap <C-L> :CtrlPMRU<CR>
nmap <C-E> :CtrlPBufTagAll<CR>
nmap <Leader>tc :CtrlPBufTag<CR>
nmap <Leader>ta :CtrlPTag<CR>
