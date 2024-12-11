# =============================================================================
#                           Directory Hook Functions
# =============================================================================

# Enhanced cd function that sources directory-specific scripts
# This function overrides the built-in cd command to add extra functionality
# It sources a .zsh file named after the directory when entering it
#
# Usage: cd [directory]
# Example: cd project_dir (will source $XDG_CONFIG_HOME/cd_scripts/project_dir.zsh if it exists)
function cd {
    # First use the built-in cd
    builtin cd $1

    # Try to source a directory-specific script
    script_name="$XDG_CONFIG_HOME/cd_scripts/`pwd | xargs basename`"
    if [ -e ${script_name}.zsh ]; then
        source ${script_name}.zsh
    fi
}

# Create the cd_scripts directory if it doesn't exist
mkdir -p "$XDG_CONFIG_HOME/cd_scripts" 