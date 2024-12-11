# =============================================================================
#                           Development Utility Functions
# =============================================================================

# Perform a quick search and replace in files
# Usage: quick_change directory search_text replace_text
# Example: quick_change ./src "oldText" "newText"
quick_change () {
    echo "Do you want to change?"
    grep -rl "$2" $1
    grep -rl "$2" $1 | xargs sed -i "s/$2/$3/g"
}

# Update all Python packages to their latest versions
# Usage: pip_update
pip_update() {
    echo "Updating python packages..."
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

# Django management command shortcut
# Usage: manage [command]
# Example: manage migrate
function manage {
    cd ~/sourceress
    python web/manage.py "$@"
}

# Generate attribute constructors
# Usage: generate_attrs [filename]
function generate_attrs {
    python web/manage.py generate_attr_constructors -f $1
} 