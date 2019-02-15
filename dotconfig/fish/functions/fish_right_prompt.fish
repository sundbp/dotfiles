function fish_right_prompt
  if test $TERM = "dumb"
    return
  else
    set -l code $status
    if test $CMD_DURATION -gt 3000
      if test $code -ne 0
        set_color -o red
      else
        set_color -o 484
      end
      printf "~%.1fs " (math "$CMD_DURATION / 1000")
      set_color -o normal
    end
    set_color 666
    printf "%s" (command date +%H:%M:%S)
    set_color -o normal
  end
end
