function down --description 'alias down sudo ip link set wlp6s0 down'
    nmcli dev wifi radio down $argv
end
