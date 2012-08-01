function! RunPelusaCheck()
  call RunSingleConque("./pelusa_check_no_colors.sh" . " " . bufname('%'))
  "call RunSingleConque("./pelusa_check.sh" . " " . bufname('%'))
endfunction
nnoremap <silent> <Leader>p  :call RunPelusaCheck()<CR>


