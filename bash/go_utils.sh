#!/usr/bin/env bash

if command -v goenv &>/dev/null; then
  export GOENV_ROOT="$HOME/.goenv"
  PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
fi

PATH="$GOROOT/bin:$PATH"
PATH="$PATH:$GOPATH/bin"

export PATH
