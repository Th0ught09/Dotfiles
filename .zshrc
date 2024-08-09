eval "$(starship init zsh)"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

. "$HOME/.cargo/env"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# execute waybar
# if [[ -z $WAYBAR ]]; then
#   export WAYBAR=1
#   waybar
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ENVIRONMENT VARIABLES

export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/kirkm/.local/share/JetBrains/Toolbox/scripts:/home/kirkm/bin"

# ALIASES

alias vi="nvim"
alias entry="vi ~/Uni/Essentials/Diary/$(date -u +%Y-%m-%d.md)"
alias zrc="vi ~/.zshrc"
alias src="source ~/.zshrc"
alias zj="zellij"
alias clear="clear; tput cup $LINES"
alias ls="lsd"
alias uni="vi ~/Uni"

# FUNCTIONS

cd(){
    echo "Time to use z"
  }

# SOURCING

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# OPTIONS

set -o vi
pokemon-colorscripts -r --no-title
tput cup $LINES
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
lisgd -g "3,RL,swaymsg workspace next" -d /dev/input/by-path/platform-AMDI0010:00-event -r 45 -m 1200 -t 100 &
lisgd -g "3,LR,swaymsg workspace prev" -d /dev/input/by-path/platform-AMDI0010:00-event -r 45 -m 1200 -t 100 &
