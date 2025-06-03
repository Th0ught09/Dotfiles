function ta --wraps='tmux attach -d -t' --description 'alias ta tmux attach -d -t'
  tmux attach -d -t $argv
        
end
