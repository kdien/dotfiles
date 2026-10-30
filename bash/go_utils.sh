#!/usr/bin/env bash
# shellcheck disable=SC1090

if command -v goenv &>/dev/null; then
  export GOENV_ROOT="$HOME/.goenv"
  PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
else
  export GOPATH="${GOPATH:-$HOME/go}"
fi

PATH="$GOPATH/bin:$PATH"
export PATH
