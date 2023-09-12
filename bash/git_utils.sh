#!/usr/bin/env bash

alias gb='git branch -vv'
alias gd='git diff'
alias glog='git log --graph --decorate --oneline'
alias gs='git status'

gtop() {
    cd "$(git rev-parse --show-toplevel)" || return
}

git_clean_branches() {
    git fetch -p
    git branch -vv | grep ': gone]' | while read -r branch; do
        git branch -D "${branch%% *}"
    done
}

git_https() {
    git remote set-url origin "$(git remote get-url origin | sed -e 's/git@bitbucket\.org:/https:\/\/kdien@bitbucket\.org\//')"
}

git_ssh() {
    git remote set-url origin "$(git remote get-url origin | sed -e 's/https:\/\/kdien@bitbucket\.org\//git@bitbucket\.org:/')"
}
