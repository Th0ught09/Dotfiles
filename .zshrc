. "$HOME/.cargo/env"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

plugins=(git z fzf )

source $ZSH/oh-my-zsh.sh

# ENVIRONMENT VARIABLES

export WAYLAND_DISPLAY=wayland-1
export CALIBRE_USE_DARK_PALETTE=0
export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/kirkm/.local/share/JetBrains/Toolbox/scripts:/home/kirkm/bin:/home/kirkm/.dotnet/tools:/home/kirkm/.local/bin"

# ALIASES

alias vi="nvim"
alias entry="vi ~/Uni/Essentials/Diary/$(date -u +%Y-%m-%d.md)"
alias zrc="vi ~/.zshrc"
alias src="source ~/.zshrc"
alias zj="zellij"
alias clear="clear; tput cup $LINES"
alias ls="lsd"
alias uni="vi ~/Uni"
alias update="sudo dnf update && sudo dnf upgrade"
alias rw="/home/kirkm/.local/share/Steam/steamapps/common/RimWorld/RimWorldLinux" 

# FUNCTIONS

# cd(){
#     echo "Time to use z"
#   }


# SOURCING

source ~/powerlevel10k/powerlevel10k.zsh-theme

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# OPTIONS

set -o vi

tput cup $LINES
pokemon-colorscripts -r --no-title
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# lisgd -g "3,RL,swaymsg workspace next" -d /dev/input/by-path/platform-AMDI0010:00-event -r 45 -m 1200 -t 100 &
# lisgd -g "3,LR,swaymsg workspace prev" -d /dev/input/by-path/platform-AMDI0010:00-event -r 45 -m 1200 -t 100 &
# xmodmap ~/.Xmodmap

if [[ -z $TMUX ]] then
  tmux
fi
