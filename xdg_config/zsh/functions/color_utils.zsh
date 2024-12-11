# =============================================================================
#                               Color Utility Functions
# =============================================================================

# Display all available terminal colors with their codes
# Usage: print_all_the_colors
print_all_the_colors() {
    for code in {000..255}; do 
        print -P -- "$code: %F{$code}Test%f"
    done
} 