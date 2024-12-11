# =============================================================================
#                               Git Aliases and Functions
# =============================================================================

# -----------------------------------------------------------------------------
#                               Basic Git Commands
# -----------------------------------------------------------------------------
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'  # Safer than --force
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsuv='git push --set-upstream origin $(git_current_branch) --no-verify'
alias grb='git rebase'
alias gst='git status'
alias gsta='git stash'
alias gstp='git stash pop'
alias glg='git log --graph --oneline --decorate'
alias gclean='git clean -fd'
alias greset='git reset --hard'
alias gundo='git reset --soft HEAD~1'
alias gitdev='git fetch origin develop && git checkout develop && git pull origin develop'

# -----------------------------------------------------------------------------
#                               Git Log Formatting
# -----------------------------------------------------------------------------
# Show commits with custom format: hash, decorations, message, and committer
alias gls='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'

# Show commits with files changed and statistics
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'

# Show commits with relative dates
alias gdate='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'

# Show commits with short dates
alias gdatelong='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

# -----------------------------------------------------------------------------
#                               Git Maintenance
# -----------------------------------------------------------------------------
# Delete all remote tracking branches that no longer exist on remote
alias git_prune="git fetch --prune && git branch -vv | grep 'origin/.*: gone]' | awk '{print \$1}' | xargs git branch -d"

# Search for files in git repo
alias gfind='git ls-files | grep -i'

# -----------------------------------------------------------------------------
#                               Work in Progress
# -----------------------------------------------------------------------------
# Quickly save work in progress - useful for switching tasks
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "[WIP]: $(date)"'

# Undo last commit but keep changes
alias gundo='git reset HEAD~'

# -----------------------------------------------------------------------------
#                               Rebase Utilities
# -----------------------------------------------------------------------------
# Rebase current branch on master with automatic master update
# Usage: gmrebase
# This function will:
# 1. Switch to master branch
# 2. Pull latest changes
# 3. Switch back to your branch
# 4. Rebase your branch onto updated master
gmrebase() {
    echo "==> Checking out master..."
    git checkout master
    echo ""
    echo "==> Updating master..."
    git pull
    echo ""
    echo "==> Checking back to original branch"
    git checkout -
    echo ""
    echo "==> Rebasing master onto $(git rev-parse --abbrev-ref HEAD)"
    git rebase master $(git rev-parse --abbrev-ref HEAD)
    echo ""
}

# Rebase current branch on main with automatic main update
# Usage: gnrebase
# Similar to gmrebase but for repositories using 'main' as default branch
# This function will:
# 1. Switch to main branch
# 2. Pull latest changes
# 3. Switch back to your branch
# 4. Rebase your branch onto updated main
gnrebase() {
    echo "==> Checking out main..."
    git checkout main
    echo ""
    echo "==> Updating main..."
    git pull
    echo ""
    echo "==> Checking back to original branch"
    git checkout -
    echo ""
    echo "==> Rebasing main onto $(git rev-parse --abbrev-ref HEAD)"
    git rebase main $(git rev-parse --abbrev-ref HEAD)
    echo ""
}

# Interactive rebase from the merge-base with master
# Usage: gmsquash
# This is useful for cleaning up your branch's commits before merging
# It will automatically find the point where your branch diverged from master
gmsquash() {
    COMMIT_HASH=$(git merge-base master HEAD)
    echo "Rebasing from: $COMMIT_HASH"
    git rebase -i "$COMMIT_HASH"
}

# Push current branch and set upstream
# Usage: gpo
# This is a shortcut for pushing a new branch and setting up tracking
# It automatically determines the current branch name
gpo() {
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}