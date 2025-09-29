function ripenate
    fish_commandline_append ' | rg -e ""'
    commandline -f end-of-line
    commandline -f backward-char
end
