source ~/.config/zsh/zshrc

# if [[ -z $TMUX ]]; then
#   tmux
# fi

# >>> conda initialize >>>
__conda_setup="$('/home/kirkm/.conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kirkm/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/kirkm/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/kirkm/.conda/bin:$PATH"
    fi
fi
unset __conda_setup

