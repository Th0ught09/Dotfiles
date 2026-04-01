function kts --wraps='sudo systemctl start katana-internalKeyboard' --wraps='sudo systemctl start kanata-internalKeyboard' --description 'alias kts sudo systemctl start kanata-internalKeyboard'
    sudo systemctl start kanata-internalKeyboard $argv
end
