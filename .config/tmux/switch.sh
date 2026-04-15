#!/bin/bash
SESSION=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Switch to: ")
if [ -n "$SESSION" ]; then
    tmux switch-client -t "$SESSION"
fi
