# General system aliases
if [ "$(uname)" = "Darwin" ]; then
    # macOS specific aliases can go here
    alias ls='ls -G'
else
    alias ls='ls -F --color=auto --group-directories-first --sort=version'
    alias ldr='ls --color --group-directories-first'
    alias ldl='ls --color -l --group-directories-first'
fi

# Common ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

# History search
alias h="history|grep "

# Package management
alias agi='sudo apt-get install '
alias agu='sudo apt-get update && sudo apt-get upgrade'

# Source configuration
alias s='source ${ZDOTDIR}/.zshrc' 