" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_theme='skwp'
let g:Powerline_colorscheme='skwp'
let g:Powerline_mode_v="V"
let g:Powerline_mode_V="V-L"
let g:Powerline_mode_cv="V⋅B"
let g:Powerline_mode_s="S"
let g:Powerline_mode_S="S-L"
let g:Powerline_mode_cs="S-B"
let g:Powerline_mode_i="I"
let g:Powerline_mode_R="R"
let g:Powerline_mode_n="N"

call Pl#Theme#InsertSegment('mode_indicator', 'before', 'fugitive:branch')
call Pl#Theme#InsertSegment('tagbar:currenttag', 'after', 'flags.mod')


