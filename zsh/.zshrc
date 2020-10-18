# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions

# Set up some useful environment variables
export HISTFILESIZE=
export HISTFILE=$HOME/.zsh_history
export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
export LS_COLORS="ow=01;36;40"
[[ $(command -v powershell.exe) ]] && export WIN_HOME=/mnt/c/Users/$(powershell.exe '$env:USERPROFILE' | cut -d '\' -f 3 | sed -e 's/\r//')

# Load completion scripts
autoload -U compinit && compinit

