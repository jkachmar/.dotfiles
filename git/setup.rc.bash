# my own git aliases
alias gpp='git pull --prune'

alias get-git-branch-name='git rev-parse --abbrev-ref HEAD'
alias ggbn='get-git-branch-name'

alias gib='git branch -v'

alias gs='git status -sb'
alias gis='git status -sb'

alias gid='git diff'
alias gids='git diff --staged'

alias getlastcommit='git show --oneline | awk NR==1'
alias glc='getlastcommit'

alias push-current-branch-to-justinwoo='git push -u justinwoo $(git rev-parse --abbrev-ref HEAD)'
alias push-current-branch-to-origin='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gpj='push-current-branch-to-justinwoo'
alias gpo='push-current-branch-to-origin'
alias gfo='git fetch origin'
alias gfp='gfo -p && dmb'
alias gfu='git fetch upstream'
alias gfj='git fetch justinwoo'

alias delete-merged-branches='git delete-merged-branches'
alias dmb='delete-merged-branches';

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcane='git commit --amend --no-edit'
alias .gcane='git add . && gcane'
alias gcanera='git commit --amend --no-edit --reset-author'

alias ga='git add'
alias ga.='git add .'
alias gap='git add -p'

alias grl='git reflog | head -10'

alias git-commits-since-origin-master='git log "origin/master..$(ggbn)" --pretty="format:* %s"'

# hub
alias hc='hub clone'
alias hb='hub browse'
alias hpr='hub pull-request'
alias hrr='hub remote rename'
alias hrrou='hub remote rename origin upstream'
alias hrrjo='hub remote rename justinwoo origin'

# pretty colors
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gil='git log --decorate=full --stat --graph'
alias gild='git log --decorate'

# hell fuckin yeah get that fuckin shit done
alias gu='git fetch origin master && git rebase origin/master'
alias gudev='git fetch origin dev && git rebase origin/dev'
alias gupdate='git fetch origin master && git rebase origin/master'
alias gbupdate='git fetch origin $(ggbn) && git rebase FETCH_HEAD'
alias gbupstream='git fetch upstream $(ggbn) && git rebase FETCH_HEAD'
alias gupstream='git fetch upstream master && git rebase FETCH_HEAD'
alias greset='git fetch origin $(ggbn) && git reset --hard FETCH_HEAD'
alias gureset='git fetch upstream $(ggbn) && git reset --hard FETCH_HEAD'
alias gjreset='git fetch justinwoo $(ggbn) && git reset --hard FETCH_HEAD'
# update children
alias gpullallchildren='ls -d */ | xargs -P10 -I{} git -C {} pull'
alias gpac='gpullallchildren'
