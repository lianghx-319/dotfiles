status is-interactive || exit

set -g _batman_color_gray 666
set -g _batman_color_yellow fa0
set -g _batman_color_blue 36f
set -g _batman_color_red f06

function __batman_color_dim; set_color $_batman_color_gray; end
function __batman_color_fst; set_color -o $_batman_color_yellow; end
function __batman_color_snd; set_color -o $_batman_color_blue; end
function __batman_color_trd; set_color -o $_batman_color_red; end
function __batman_color_off; set_color normal; end

function _batman_postexec --on-event fish_postexec
    test "$CMD_DURATION" -lt 1000 && set _batman_cmd_duration && return

    set --local secs (math --scale=1 $CMD_DURATION/1000 % 60)
    set --local mins (math --scale=0 $CMD_DURATION/60000 % 60)
    set --local hours (math --scale=0 $CMD_DURATION/3600000)

    test $hours -gt 0 && set --local --append out (__batman_color_dim)$hours(__batman_color_fst)"h"
    test $mins -gt 0 && set --local --append out (__batman_color_dim)$mins(__batman_color_fst)"m"
    test $secs -gt 0 && set --local --append out (__batman_color_dim)$secs(__batman_color_fst)"s"

    set --global _batman_cmd_duration "$out"(__batman_color_off)" "
end

