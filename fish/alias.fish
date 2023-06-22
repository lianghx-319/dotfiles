# Alias with token
function git
  set -l GITHUB_TOKEN (pass show github/personal/token)
  command git $argv
end
# Section: General
abbr -a c clear
abbr h "history"
abbr o "open"
abbr -a cat "bat"
abbr -a change "nvim ~/.config/fish/config.fish"
abbr -a update "source ~/.config/fish/config.fish"

# Exa
abbr -a l "exa --icons"
abbr -a ll "exa --all --long --header --group-directories-first --time-style long-iso --git --git-ignore"
abbr -a ls "exa --oneline --all --group-directories-first"
abbr -a tree "exa --tree"

abbr -a vi nvim

# Lazygit
abbr -a lg "lazygit"

# Git
abbr -a gaa "git add --all"
abbr -a gcl "ghq get"
abbr -a gb "git switch"
abbr -a gbb "git switch -"
abbr gbm 'git switch (git_main_branch)'
abbr -a gco "git checkout"
abbr -a gcp "git cherry-pick"
abbr -a gcpa "git cherry-pick --abort"
abbr -a gcps "git cherry-pick --skip"
abbr -a gcm "git commit -m"
abbr -a gcam "git commit -a -m"
abbr -a gca "git commit --amend --no-edit"
abbr -a gcae "git commit --amend"
abbr -a gcaa "git add --all; git commit --amend --no-edit"
abbr -a gcaae "git add --all; git commit --amend"
abbr -a gap "git add -p"
abbr -a gnope "git checkout ."
abbr -a gwait "git reset HEAD"
abbr -a gundo "git reset --soft HEAD^"
abbr -a greset "git clean -f; git reset --hard HEAD" # Removes all changes, even untracked files
abbr -a gl "git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
abbr -a glb "git log --oneline --decorate --graph --all"
abbr -a gst "git status -s --branch"
abbr -a gpl "git pull --rebase"
abbr -a gps "git push"
abbr -a gpsf "git push --force-with-lease"
abbr -a grp "git remote prune"
abbr -a grb "git rebase"
abbr -a grbi "git rebase -i"
abbr -a grba "git rebase --abort"
abbr -a grbc "git rebase --continue"
