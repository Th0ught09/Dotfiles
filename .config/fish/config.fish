if status is-interactive
    # Commands to run in interactive sessions can go here
    /usr/bin/pokemon-colorscripts --no-title -r
    tput cup $LINES
    function ls --wraps='eza --icons' --description 'alias ls eza --icons'
        eza --icons $argv
    end
end

starship init fish | source
set -U fish_greeting
set -Ux EDITOR "emacsclient -c"
set -Ux LFS /mnt/lfs
bind -M insert up history-prefix-search-backward
bind -M insert ctrl-x fg
bind -M insert alt-r ripper end-of-line
set -U fish_history_search_prefix_only true
