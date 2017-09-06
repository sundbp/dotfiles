function fish_right_prompt
  if test $CMD_DURATION -gt 1000
    set_color -o magenta
    printf "took ~%.1fs " (math "$CMD_DURATION / 1000")
    set_color -o normal
  end
  set_color 666
  printf "%s" (command date +%H:%M:%S)
  set_color -o normal
end
