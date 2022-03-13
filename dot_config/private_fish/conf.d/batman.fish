status is-interactive || exit

set --query batman_color_gray || set --global batman_color_gray 666
set --query batman_color_yellow || set --global batman_color_yellow fa0
set --query batman_color_blue || set --global batman_color_blue 36f
set --query batman_color_red || set --global batman_color_red f06
# back up green 8AEA92 5EFC8D
set --query batman_color_green || set --global batman_color_green 16F4D0

function __batman_color_gray; set_color $batman_color_gray; end
function __batman_color_yellow; set_color -o $batman_color_yellow; end
function __batman_color_blue; set_color -o $batman_color_blue; end
function __batman_color_red; set_color -o $batman_color_red; end
function __batmon_color_fth; set_color -o $batman_color_green; end
function __batman_color_off; set_color normal; end

function _batman_postexec --on-event fish_postexec
    test "$CMD_DURATION" -lt 1000 && set _batman_cmd_duration && return

    set --local secs (math --scale=1 $CMD_DURATION/1000 % 60)
    set --local mins (math --scale=0 $CMD_DURATION/60000 % 60)
    set --local hours (math --scale=0 $CMD_DURATION/3600000)

    test $hours -gt 0 && set --local --append out (__batman_color_gray)$hours(__batman_color_yellow)"h"
    test $mins -gt 0 && set --local --append out (__batman_color_gray)$mins(__batman_color_yellow)"m"
    test $secs -gt 0 && set --local --append out (__batman_color_gray)$secs(__batman_color_yellow)"s"

    set --global _batman_cmd_duration "$out"(__batman_color_off)" "
end

# fish git prompt options
set --query __fish_git_prompt_show_informative_status || set -g __fish_git_prompt_show_informative_status
set --query __fish_git_prompt_showcolorhints || set -g __fish_git_prompt_showcolorhints
set --query __fish_git_prompt_showdirtystate || set -g __fish_git_prompt_showdirtystate
set --query __fish_git_prompt_showuntrackedfiles || set -g __fish_git_prompt_showuntrackedfiles
set --query __fish_git_prompt_showstashstate || set -g __fish_git_prompt_showstashstate
set --query __fish_git_prompt_showupstream || set -g __fish_git_prompt_showupstream "informative"

# fish git prompt colors
set --query __fish_git_prompt_color_branch || set -g __fish_git_prompt_color_branch $batman_color_yellow --bold
set --query __fish_git_prompt_color_dirtystate || set -g __fish_git_prompt_color_dirtystate $batman_color_red
set --query __fish_git_prompt_color_invalidstate || set -g __fish_git_prompt_color_invalidstate $batman_color_red
set --query __fish_git_prompt_color_merging || set -g __fish_git_prompt_color_merging $batman_color_blue
set --query __fish_git_prompt_color_stagedstate || set -g __fish_git_prompt_color_stagedstate $batman_color_green
set --query __fish_git_prompt_color_upstream_ahead || set -g __fish_git_prompt_color_upstream_ahead $batman_color_blue
set --query __fish_git_prompt_color_upstream_behind || set -g __fish_git_prompt_color_upstream_behind $batman_color_blue
set --query __fish_git_prompt_color_cleanstate || set -g __fish_git_prompt_color_cleanstate $batman_color_green
set --query __fish_git_prompt_color_untrackedfiles || set -g __fish_git_prompt_color_untrackedfiles $batman_color_red
set --query __fish_git_prompt_color_upstream || set -g __fish_git_prompt_color_upstream $batman_color_yellow
set --query __fish_git_prompt_color_flags || set -g __fish_git_prompt_color_flags $batman_color_yellow
set --query __fish_git_prompt_color_branch_detached || set -g __fish_git_prompt_color_branch_detached $batman_color_red

# fish prompt symble
set --query __fish_git_prompt_char_cleanstate || set -g __fish_git_prompt_char_cleanstate '✔'
set --query __fish_git_prompt_char_dirtystate || set -g __fish_git_prompt_char_dirtystate '*'
set --query __fish_git_prompt_char_invalidstate || set -g __fish_git_prompt_char_invalidstate '#'
set --query __fish_git_prompt_char_stagedstate || set -g __fish_git_prompt_char_stagedstate '+'
set --query __fish_git_prompt_char_stashstate || set -g __fish_git_prompt_char_stashstate '$'
set --query __fish_git_prompt_char_stateseparator || set -g __fish_git_prompt_char_stateseparator ' '
set --query __fish_git_prompt_char_untrackedfiles || set -g __fish_git_prompt_char_untrackedfiles '%'
set --query __fish_git_prompt_char_upstream_ahead || set -g __fish_git_prompt_char_upstream_ahead '>'
set --query __fish_git_prompt_char_upstream_behind || set -g __fish_git_prompt_char_upstream_behind '<'
set --query __fish_git_prompt_char_upstream_diverged || set -g __fish_git_prompt_char_upstream_diverged '<>'
set --query __fish_git_prompt_char_upstream_equal || set -g __fish_git_prompt_char_upstream_equal '=' 

# fish syntax highlight override
set -g fish_color_command $batman_color_blue
set -g fish_color_keyword $batman_color_yellow
set -g fish_color_quote $batman_color_green
set -g fish_color_end $batman_color_red
set -g fish_color_error $batman_color_red
set -g fish_color_param $batman_color_yellow --bold
set -g fish_color_option $batman_color_blue
set -g fish_color_comment $batman_color_gray
set -g fish_color_operator $batman_color_green
set -g fish_color_redirection $batman_color_blue
set -g fish_color_search_match --background $batman_color_green