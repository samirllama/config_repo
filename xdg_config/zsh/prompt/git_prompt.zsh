# =============================================================================
#                               Git-Aware Prompt Configuration
# =============================================================================

# -----------------------------------------------------------------------------
#                               Environment Setup
# -----------------------------------------------------------------------------
# Enable/disable features
export PROMPT_DEBUG=${PROMPT_DEBUG:-false}  # Debug mode for prompt
export PROMPT_GIT=${PROMPT_GIT:-true}       # Git integration in prompt
export IS_A_GIT_DIR=0                       # Git directory status

# Prompt appearance configuration
export PROMPT_MAX_COMMIT_LENGTH=35          # Maximum length for commit messages
export PROMPT_ELLIPSIS_LENGTH=$((PROMPT_MAX_COMMIT_LENGTH - 3))

# -----------------------------------------------------------------------------
#                               Utility Functions
# -----------------------------------------------------------------------------
# Debug print function
prompt_print_debug() {
    [[ $PROMPT_DEBUG == true ]] && print "$@"
}

# Get pure string length (excluding color codes)
prompt_pure_string_length() {
    local str=$1
    echo $(( ${#${(S%%)str//(\%([KF1]|)\{*\}|\%[Bbkf])}} ))
}

# -----------------------------------------------------------------------------
#                               Git Status Functions
# -----------------------------------------------------------------------------
# Check if current directory is in a Git repository
set_git_dir() {
    if [[ $PROMPT_GIT == true ]]; then
        if [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1; then
            export IS_A_GIT_DIR=1
        else
            export IS_A_GIT_DIR=0
        fi
    else
        export IS_A_GIT_DIR=0
    fi
}

# Get current commit hash
get_commit_hash(){
    [[ $IS_A_GIT_DIR -eq 1 ]] && print "[%F{yellow}$(git log --pretty=format:'%h' -n 1)%f]"
}

# Get current commit message
get_commit_message(){
    if [[ $IS_A_GIT_DIR -eq 1 ]]; then
        local COMMIT_MESSAGE="$(git log -1 --pretty=%B | head -n1)"
        if [[ ${#COMMIT_MESSAGE} -gt $((PROMPT_ELLIPSIS_LENGTH + 1)) ]]; then
            printf "[ %%F{blue}%${PROMPT_ELLIPSIS_LENGTH}.${PROMPT_ELLIPSIS_LENGTH}s...%%f ]" $COMMIT_MESSAGE
        else
            printf "[ %%F{blue}%${PROMPT_MAX_COMMIT_LENGTH}.${PROMPT_MAX_COMMIT_LENGTH}s%%f ]" $COMMIT_MESSAGE
        fi
    fi
}

# Get current Git branch
get_git_branch() {
    [[ $IS_A_GIT_DIR -eq 1 ]] && print "%F{green}$(git rev-parse --abbrev-ref HEAD)%f"
}

# -----------------------------------------------------------------------------
#                               Python Environment
# -----------------------------------------------------------------------------
# Get Python virtual environment info
get_pyenv_version() {
    if [[ -n $PYENV_VERSION ]]; then
        print "%F{cyan}($PYENV_VERSION)%f"
    elif [[ -n $VIRTUAL_ENV ]]; then
        print "%F{cyan}($(basename $VIRTUAL_ENV))%f"
    fi
}

# -----------------------------------------------------------------------------
#                               Directory Display
# -----------------------------------------------------------------------------
# Enhanced current directory display
my_current_directory() {
    if [[ $IS_A_GIT_DIR -eq 1 ]]; then
        local git_root="$(git rev-parse --show-toplevel)"
        local current_dir="$(pwd)"
        
        if [[ $git_root == $current_dir ]]; then
            print "%F{blue}\ue0a0%f%F{magenta}/${git_root:t}%f"
        else
            git_root="${git_root:h}"
            print "%F{blue}\ue0a0%f%F{magenta}${current_dir#$git_root}%f"
        fi
    else
        print "%F{magenta}%~%f"
    fi
}

# -----------------------------------------------------------------------------
#                               Prompt Setup
# -----------------------------------------------------------------------------
# Set up the prompt with precmd hook
setopt PROMPT_SUBST
function precmd() {
    set_git_dir
}

# Define the prompt
PROMPT='$(get_pyenv_version) %F{yellow}%B%T%b%f %F{green}%n%f:%F{blue}$(my_current_directory)%f $(get_commit_hash) $(get_commit_message)
%F{yellow}>>%f ' 