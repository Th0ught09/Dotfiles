if status is-interactive
    # Commands to run in interactive sessions can go here
    /usr/bin/pokemon-colorscripts --no-title -r
    tput cup $LINES
end

starship init fish | source
set -U fish_greeting

bind ctrl-x fg
