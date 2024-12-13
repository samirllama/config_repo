#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

usage() {
  cat << EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-n] [-l] repository

Stack Project Archiver: Creates a clean copy of an AWS stack project while maintaining core functionality.
Perfect for archiving work projects into personal storage while removing sensitive configurations.

Available options:
-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-n, --name      New project name (default: archived-stack)
-l, --location  Target location for the archived project (default: ./archived)
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' BLUE='\033[0;34m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' BLUE='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1}
  msg "$msg"
  exit "$code"
}

sanitize_config() {
  local location=$1
  msg "${BLUE}Sanitizing configuration files...${NOFORMAT}"
  
  # Handle stack.json
  if [[ -f "$location/config/stack.json" ]]; then
    msg "${YELLOW}Sanitizing stack.json...${NOFORMAT}"
    # Preserve structure but remove sensitive values
    jq '
      walk(
        if type == "object" then
          with_entries(
            if .key | test("(password|secret|key|token|credential)"; "i") then
              .value = "REMOVED"
            else
              .
            end
          )
        else
          .
        end
      )
    ' "$location/config/stack.json" > "$location/config/stack.json.tmp"
    mv "$location/config/stack.json.tmp" "$location/config/stack.json"
  fi

  # Handle cdk.json
  if [[ -f "$location/infra/cdk.json" ]]; then
    msg "${YELLOW}Sanitizing cdk.json...${NOFORMAT}"
    jq '
      walk(
        if type == "object" then
          with_entries(
            if .key | test("(account|region|env)"; "i") then
              .value = "PLACEHOLDER"
            else
              .
            end
          )
        else
          .
        end
      )
    ' "$location/infra/cdk.json" > "$location/infra/cdk.json.tmp"
    mv "$location/infra/cdk.json.tmp" "$location/infra/cdk.json"
  fi
}

remove_git_artifacts() {
  local location=$1
  msg "${BLUE}Removing git artifacts...${NOFORMAT}"
  
  # Remove .git directory
  rm -rf "$location/.git"
  
  # Remove any git-related files
  find "$location" -name ".gitignore" -delete
  find "$location" -name ".gitmodules" -delete
  find "$location" -name ".gitattributes" -delete
}

clean_dependencies() {
  local location=$1
  msg "${BLUE}Cleaning dependency files...${NOFORMAT}"
  
  # Clean node_modules and package-lock if they exist
  rm -rf "$location/node_modules" "$location/package-lock.json"
  
  # Clean Python virtual environments and cache
  find "$location" -type d -name "venv" -exec rm -rf {} +
  find "$location" -type d -name "__pycache__" -exec rm -rf {} +
  find "$location" -type d -name ".pytest_cache" -exec rm -rf {} +
  find "$location" -type f -name "*.pyc" -delete
}

parse_params() {
  location='./archived'
  new_name='archived-stack'

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    -n | --name)
        new_name="${2-}"
        shift
        ;;
    -l | --location)
        location="${2-}"
        shift
        ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")
  [[ ${#args[@]} -eq 0 ]] && die "Missing repository argument"
  return 0
}

parse_params "$@"
setup_colors

# Create fresh copy
msg "${YELLOW}Creating clean copy in $location...${NOFORMAT}"
mkdir -p "$location"
cp -r "${args[0]}/." "$location/"

# Clean up the project
remove_git_artifacts "$location"
clean_dependencies "$location"
sanitize_config "$location"

# Rename project if needed
if [[ "$new_name" != "archived-stack" ]]; then
  msg "${YELLOW}Renaming project to $new_name...${NOFORMAT}"
  # Update project name in package.json if it exists
  if [[ -f "$location/package.json" ]]; then
    jq ".name = \"$new_name\"" "$location/package.json" > "$location/package.json.tmp"
    mv "$location/package.json.tmp" "$location/package.json"
  fi
  # Update project name in setup.py if it exists
  if [[ -f "$location/setup.py" ]]; then
    sed -i "s/name=.*/name='$new_name',/" "$location/setup.py"
  fi
fi

msg "${GREEN}Archive complete. Stack project is now ready for personal storage.${NOFORMAT}"
msg "${BLUE}Location: $location${NOFORMAT}"
