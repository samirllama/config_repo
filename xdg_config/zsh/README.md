# Zsh Configuration Guide

## Directory Structure

```
zsh/
├── .zshrc          # Main Zsh configuration file
├── .zprofile       # Login shell configuration
├── zshenv          # Environment variables
├── aliases/        # Directory containing all alias definitions
│   ├── dev_tools.zsh    # Development tool aliases (yarn, docker, eza)
│   ├── disk.zsh         # Disk usage and management aliases
│   ├── edit.zsh         # Editor and file navigation aliases
│   ├── general.zsh      # General system aliases
│   ├── git.zsh          # Git workflow aliases
│   ├── projects.zsh     # Project-specific navigation
│   ├── ssh.zsh          # SSH connection aliases
│   ├── tmux.zsh         # Tmux session management
│   └── tree.zsh         # Tree command aliases
├── functions/      # Custom Zsh functions
├── completions/    # Custom completion definitions
├── plugins/        # Zsh plugins
└── themes/         # Custom themes

```

## Configuration Loading Order

1. `zshenv` → Always loaded first, sets up environment variables
2. `.zprofile` → Loaded for login shells, sets up Homebrew and editor preferences
3. `.zshrc` → Main configuration file, loaded for interactive shells

## Key Features

### Automatic Alias Loading

The `.zshrc` file automatically loads all alias files from the `aliases/` directory:

```zsh
for alias_file in "${ZDOTDIR}"/aliases/*(.N); do
    source "$alias_file"
done
```

This means you can:

- Add new alias files to `aliases/` without modifying `.zshrc`
- Group related aliases in separate files
- Enable/disable groups of aliases by adding/removing files

### XDG Base Directory Support

Configuration follows the XDG Base Directory Specification:

- `$XDG_CONFIG_HOME/zsh/` for configuration files
- `$XDG_DATA_HOME/zsh/` for data files (history, etc.)
- `$XDG_CACHE_HOME/zsh/` for cache files

### Modular Design

- Each type of configuration is separated into its own directory
- Functions, completions, and plugins are automatically loaded
- Easy to add or remove functionality without editing core files

## Usage Examples

### Adding New Aliases

1. Create a new file in `aliases/` directory:
   ```zsh
   touch ${ZDOTDIR}/aliases/new_aliases.zsh
   ```
2. Add your aliases to the file
3. They'll be automatically loaded next time you start a shell

### Adding Custom Functions

1. Add your function file to `functions/` directory
2. Functions are automatically loaded and available

### Managing Plugins

1. Add plugin files to `plugins/` directory
2. They're automatically sourced by `.zshrc`

## Maintenance

### Backup

The Makefile includes backup functionality:

```make
make backup
```

This creates timestamped backups of your existing configuration.

### Deployment

Deploy your configuration to a new system:

```make
make deploy
```

### Testing

Test your configuration:

```make
make test
```

## Troubleshooting

### Common Issues

1. Aliases not loading:

   - Check file permissions
   - Ensure file ends in `.zsh`
   - Verify file location in `aliases/`

2. Plugin not working:
   - Check if plugin is in `plugins/` directory
   - Verify plugin syntax
   - Check `.zshrc` for loading errors

### Debugging

Add `set -x` to the start of any `.zsh` file to enable debug output:

```zsh
set -x  # Enable debug output
# Your code here
set +x  # Disable debug output
```
