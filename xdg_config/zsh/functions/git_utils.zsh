# =============================================================================
#                               Git Utility Functions
# =============================================================================

# Show diff for a specific commit or HEAD if no commit is specified
# Usage: diff_commit [commit_hash]
# Example: diff_commit abc123
diff_commit() {
    if [ "$1" != "" ]
    then
        git diff $1~ $1
    else
        git diff HEAD~ HEAD
    fi
}

# Calculate the contribution statistics for a specific author
# Usage: author_contrib "author_name" [additional_git_log_args]
# Example: author_contrib "John Doe" "--since='1 month ago'"
author_contrib() {
    git log --author="$1" --pretty=tformat: --numstat $2 | \
        gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines: %s\n", add, subs, loc }' -
} 