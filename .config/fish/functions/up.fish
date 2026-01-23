function up --description 'alias up sudo ip link set wlp6s0 up'
    nmcli dev radio wifi up $argv
end
