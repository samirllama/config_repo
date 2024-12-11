# Basic tmux operations
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tls='tmux ls'
alias tn='tmux new -s'
alias ttop='tmux attach -t top || tmux new -s top "top"'
alias tmf_load='tmuxifier load-session'

# Remote server tmux sessions
# First check if the session exists, if not create a new one and ssh to the server
alias tpprl='tmux attach -t pprl || tmux new -s pprl "ssh pprl"'
alias tmist='tmux attach -t mist || tmux new -s mist "ssh mist"'
alias tnarval='tmux attach -t narval || tmux new -s narval "ssh narval"'
alias tbeluga='tmux attach -t beluga || tmux new -s beluga "ssh beluga"'
alias tgraham='tmux attach -t graham || tmux new -s graham "ssh graham"'

# Show available tmux sessions at login
echo "Available tmux sessions:"
tmux ls 