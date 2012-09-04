" make sure we can just hit the shortcut key and always run the specs
function! MyRunRspec()
  let l:fname = expand("%:t")
  if stridx(l:fname, "_spec.rb") == -1
    call RunRspecRelated()
  else
    call RunRspecCurrentFileConque()
  endif
endfunction

" Cmd-R for RSpec
nmap <silent> <C-R> :call MyRunRspec()<CR>
" \l for RSpec Current Line
nmap <silent> <Leader>l :call RunRspecCurrentLineConque()<CR>
" ,Cmd-R for Last conque command
nmap <silent> ,<C-R> :call RunLastConqueCommand()<CR>

" Find the related spec for any file you open.
function! RelatedFileForSpec()
  let l:fullpath = expand("%:p")
  let l:filepath = expand("%:h")
  let l:fname = expand("%:t")
  let l:filepath_as_lib = substitute(l:filepath, "spec/", "lib/", "")
  let l:filepath_as_app = substitute(l:filepath, "spec/", "app/", "")

  " Possible names for the spec/test for the file we're looking at
  let l:file_for_spec_names = [substitute(l:fname, "_spec.rb$", ".rb", "")]

  " Possible paths
  let l:file_for_spec_paths = [l:filepath_as_lib, l:filepath_as_app]

  for file_name in l:file_for_spec_names
    for path in l:file_for_spec_paths
      let l:file_for_spec_path = path . "/" . file_name
      let l:full_file_for_spec_path = substitute(l:fullpath, l:filepath . "/" . l:fname, l:file_for_spec_path, "")
      if filereadable(l:full_file_for_spec_path)
        return l:full_file_for_spec_path
      end
    endfor
  endfor
endfunction

function! RelatedFileForSpecOpen()
  let l:file_path = RelatedFileForSpec()
  if filereadable(l:file_path)
    execute ":e " . l:file_path
  endif
endfunction

function! RelatedFileForSpecVOpen()
  let l:file_path = RelatedFileForSpec()
  if filereadable(l:file_path)
    execute ":botright vsp " . l:file_path
  endif
endfunction

" make sure we can just hit the shortcut key and switch between spec and file
function! MyRelatedSpecFileSwitch()
  let l:fname = expand("%:t")
  if stridx(l:fname, "_spec.rb") == -1
    call RelatedSpecOpen()
  else
    call RelatedFileForSpecOpen()
  endif
endfunction

function! MyRelatedSpecFileVSwitch()
  let l:fname = expand("%:t")
  if stridx(l:fname, "_spec.rb") == -1
    call RelatedSpecVOpen()
  else
    call RelatedFileForSpecVOpen()
  endif
endfunction

nnoremap <silent> ,<C-s> :call MyRelatedSpecFileVSwitch()<CR>
nnoremap <silent> <C-s>  :call MyRelatedSpecFileSwitch()<CR>

