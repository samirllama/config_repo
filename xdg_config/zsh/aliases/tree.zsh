# Tree command aliases
# Ignore Python cache files and show directories first
alias pt='tree -I "__pycache__|*.pyc" --dirsfirst -v' 

# Basic usage
alias t_all="tree -h"  # Display file sizes
alias t_short="tree -L 2 --dirsfirst -F"  # Short and sweet tree

# Filtering and searching
alias t_py="tree *.py"  # Show only Python files
alias t_no_cache="tree -I '__pycache__|*.pyc'"  # Exclude Python cache
alias t_error_search="tree -P 'error'"  # Search for 'error' in file names

# Visualizing project structure
alias t_color="tree --color=always"  # Colorize output
alias t_perms="tree -p"  # Display file permissions

# Advanced usage
alias t_grep_test="tree -L 2 | grep -i 'test'"  # Combine with grep
