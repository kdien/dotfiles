#!/usr/bin/env bash

alias gb='git branch -vv'
alias gd='git diff'
alias glog='git log --graph --decorate --oneline'
alias gs='git status'

delta_theme=OneHalfDark
[[ "$TERMINAL_THEME" = 'light' ]] && delta_theme=OneHalfLight
git config --global delta.syntax-theme "$delta_theme"

gtop() {
  cd "$(git rev-parse --show-toplevel)" || return
}

git_clean_branches() {
  git fetch -p
  git branch -vv | grep ': gone]' | while read -r branch; do
    git branch -D "${branch%% *}"
  done
}

git_copy_branch() {
  local branch
  branch=$(git branch --show-current)

  if command -v pbcopy &>/dev/null; then
    pbcopy <<<"$branch"
    return
  fi

  if command -v clip.exe &>/dev/null; then
    echo -n "$branch" | clip.exe
    return
  fi

  if [[ "$XDG_SESSION_TYPE" = 'x11' ]]; then
    xclip -selection clipboard <<<"$branch"
    return
  fi

  if [[ "$XDG_SESSION_TYPE" = 'wayland' ]]; then
    wl-copy <<<"$branch"
    return
  fi
}

git_https() {
  git remote set-url origin "$(git remote get-url origin | sed -e 's/git@bitbucket\.org:/https:\/\/kdien@bitbucket\.org\//')"
}

git_ssh() {
  git remote set-url origin "$(git remote get-url origin | sed -e 's/https:\/\/kdien@bitbucket\.org\//git@bitbucket\.org:/')"
}
