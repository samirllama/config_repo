# =============================================================================
#                                   Zsh Configuration
# =============================================================================
# This is the main Zsh configuration file. It's loaded for interactive shells
# and sets up the shell environment, including aliases, completions, and prompts.

# -----------------------------------------------------------------------------
#                           XDG Base Directory Setup
# -----------------------------------------------------------------------------
# Following the XDG Base Directory Specification for config file organization
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Set Zsh configuration directory
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# -----------------------------------------------------------------------------
#                              History Configuration
# -----------------------------------------------------------------------------
# Set history file location according to XDG spec
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

# -----------------------------------------------------------------------------
#                           Directory Setup
# -----------------------------------------------------------------------------
# Create necessary directories if they don't exist
mkdir -p "${XDG_DATA_HOME}/zsh"
mkdir -p "${ZDOTDIR}/.zcomp"

# -----------------------------------------------------------------------------
#                           Completion System
# -----------------------------------------------------------------------------
# Initialize the completion system
autoload -Uz compinit
compinit -d "${ZDOTDIR}/.zcomp/zcompdump"

# -----------------------------------------------------------------------------
#                           Module Loading
# -----------------------------------------------------------------------------
# Load custom functions
# Functions in this directory are automatically loaded and made available
fpath=("${ZDOTDIR}/functions" $fpath)
for func in "${ZDOTDIR}"/functions/*(.N); do
    autoload -Uz "${func:t}"
done

# Load aliases
# Each file in aliases/ contains a group of related aliases
# Files are automatically loaded, so you can add new files without modifying this config
for alias_file in "${ZDOTDIR}"/aliases/*(.N); do
    source "$alias_file"
done

# Load custom completions
fpath=("${ZDOTDIR}/completions" $fpath)

# Load plugins
# Add your plugins to the plugins directory and they'll be loaded automatically
for plugin in "${ZDOTDIR}"/plugins/*(.N); do
    source "$plugin"
done

# -----------------------------------------------------------------------------
#                           Shell Options
# -----------------------------------------------------------------------------
setopt AUTO_CD              # Change directory without cd
setopt EXTENDED_GLOB        # Extended globbing
setopt NOMATCH             # Error if glob has no matches
setopt NOTIFY              # Report status of background jobs immediately
setopt PROMPT_SUBST        # Enable parameter expansion in prompts

# -----------------------------------------------------------------------------
#                           Key Bindings
# -----------------------------------------------------------------------------
bindkey -e                  # Use emacs key bindings
bindkey '^[[A' up-line-or-search    # Up arrow for history search
bindkey '^[[B' down-line-or-search  # Down arrow for history search

# -----------------------------------------------------------------------------
#                           Prompt Configuration
# -----------------------------------------------------------------------------
# Load the Git-aware prompt configuration
source "${ZDOTDIR}/prompt/git_prompt.zsh"