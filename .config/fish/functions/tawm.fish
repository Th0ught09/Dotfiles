function tawm --description 'testing awesome config'
    export DISPLAY=:0
    Xephyr -br -ac -noreset -screen 1280x720 :1 &
    sleep 1
    export DISPLAY=:1
    awesome
end
