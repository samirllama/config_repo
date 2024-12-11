# Disk usage aliases
# Show disk usage sorted by size
alias diskspace="du -S | sort -n -r |more"

# Show size of directories in current path
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn" 