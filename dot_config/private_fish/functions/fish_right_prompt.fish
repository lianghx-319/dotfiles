function fish_right_prompt
  set -l code $status
  test $code -ne 0; and echo (__batman_color_gray)"("(__batman_color_red)"$code"(__batman_color_gray)") "(__batman_color_off)

  if test -n "$SSH_CONNECTION"
     printf (__batman_color_red)":"(__batman_color_gray)"$HOSTNAME "(__batman_color_off)
   end

  printf '%s ' (__fish_git_prompt | string trim)
  printf $_batman_cmd_duration
end
