function kto --wraps='sudo systemctl stop kanata-internalKeyboard' --description 'alias kto sudo systemctl stop kanata-internalKeyboard'
    sudo systemctl stop kanata-internalKeyboard $argv
end
