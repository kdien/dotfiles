# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f $HOME/.p10k.zsh ]] && source $HOME/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

[[ -f $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases
[[ -f $HOME/.zsh_functions ]] && source $HOME/.zsh_functions

# Set up `brew` completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Set up some useful environment variables
export HISTFILESIZE=
export HISTFILE=$HOME/.zsh_history
export JAVA_HOME=/opt/homebrew/opt/openjdk@11

# Load completion scripts
autoload -U compinit && compinit

