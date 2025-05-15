export DISPLAY=:0

# OPTS

CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# PLUGINS

plugins=(
  git 
  fzf 
  1password 
  zoxide 
  vi-mode 
  sudo 
  alias-finder 
  zsh-autosuggestions 
  zsh-syntax-highlighting
  autoswitch_virtualenv
)

# ZSTYLES

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default


# ENVIRONMENT VARIABLES

# export XDG_CURRENT_DESKTOP=Sway
# export WAYLAND_DISPLAY=wayland-0
export CALIBRE_USE_DARK_PALETTE=0
export EDITOR=nvim
export FZF_DEFAULT_OPTS="--tmux center"
export ZSH="$HOME/.oh-my-zsh"
# export PATH="$PATH:/home/kirkm/.local/share/JetBrains/Toolbox/scripts:/home/kirkm/.dotnet/tools:/home/kirkm/.local/bin"
PATH=$PATH:/home/kirkm/.config/emacs/bin:/home/kirkm/.scripts
export DOOMDIR=~/.config/doom
export LD_LIBRARY_PATH=/home/kirkm/.local/share/nvim/mason/bin:/home/kirkm/Programs:/home/kirkm/miniconda3/bin:/home/kirkm/.config/emacs/bin:/home/kirkm/Programs:/home/kirkm/miniconda3:$LD_LIBRARY_PATH

# SOURCING

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

# ALIASES

alias push="git add .; git commit -m 'push for $(date -u +%Y-%m-%dT%H:%M:%S)'; git push"
alias nv="vi ~/.config/home-manager/home.nix"
alias zt="zathura"
alias ta="tmux attach -d -t"
alias vi="nvim"
alias zrc="vi ~/.zshrc"
alias src="source ~/.zshrc"
alias ls="eza --icons"
alias clear="clear; tput cup $LINES"
alias note="vi ~/Documents/Vault"
alias update="sudo dnf update && sudo dnf upgrade"
alias rw="/home/kirkm/.local/share/Steam/steamapps/common/RimWorld/RimWorldLinux" 
alias ca="conda activate"
alias ac="conda deactivate"
alias srch="nix-env -qaP"
alias install="sudo dnf install"
alias zra="zrc +43"
alias netsp="speedtest-cli --simple"
alias gdb="gdb -q"
alias sp="sudo systemctl suspend"
alias emacs="emacsclient -c -a 'emacs'"
alias mb="fuck"

# FUNCTIONS

# Force use z
# cd(){
#     echo "Time to use z/fzf"
#   }

# Don't install python packages outside of a conda env
# function pip(){
#     if [[ -z $CONDA_PREFIX || $CONDA_PREFIX == "/usr" ]]
#       then
#         echo "do not install python packages outside of or in a base conda env!!"
#         return
#     else
#       command pip $@
#     fi
# }

# Quick ls grep
lg(){
  l | grep $1
}

# Quick search into language dir

function lr () { z Lang $1 }

# SETTINGS  

set -o vi

# COMMANDS

# xrandr --output HDMI-A-0 --primary --output DisplayPort-1 --right-of HDMI-A-0
tput cup $LINES
colorscript random
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/kirkm/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/kirkm/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/kirkm/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/kirkm/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
