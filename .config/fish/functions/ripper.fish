function ripper --wraps='self-insert | rg' --description 'alias ripper self-insert | rg'
    fish_commandline_append " | rg "
end
