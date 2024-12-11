# =============================================================================
#                               Neovim Utility Functions
# =============================================================================

# Open Neovim with demo configuration
# Usage: dvim [filename]
function dvim {
    nvim -u ~/git/config_manager/test/demo_init.vim $1
}

# Create a demo GIF using Neovim
# Usage: demogif input_file output_file [width] [height]
# Example: demogif example.py demo.gif 132 24
function demogif {
    local width="${3:=132}"
    local height="${4:=24}"

    # Set terminal size
    printf '\033[8;'$height';'$width't'

    termtosvg -g "$width"x"$height" $2 -c "nvim -u ~/git/config_manager/test/demo_init.vim $1"
}

# Create a GIF of regular Neovim usage
# Usage: nvimgif input_file output_file [width] [height]
# Example: nvimgif example.py demo.gif 132 24
function nvimgif {
    local width="${3:=132}"
    local height="${4:=24}"

    # Set terminal size
    printf '\033[8;'$height';'$width't'

    termtosvg -g "$width"x"$height" $2 -c "nvim $1"
} 