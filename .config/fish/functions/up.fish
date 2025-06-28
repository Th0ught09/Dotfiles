function up --description 'alias up sudo ip link set enp3s0 up'
  sudo ip link set enp3s0 up $argv
        
end
