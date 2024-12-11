# Config Repository

A comprehensive configuration management repository wit XDG base directory specification compliance.

## Structure

```
.
├── xdg_config/
│   ├── zsh/
│   │   ├── .zcomp/         # Zsh completion cache
│   │   ├── completions/    # Custom completion scripts
│   │   ├── aliases/        # Custom aliases
│   │   ├── functions/      # Custom Zsh functions
│   │   ├── plugins/        # Additional Zsh plugins
│   │   ├── themes/         # Custom themes
│   │   ├── prompt/         # Prompt configurations
│   │   ├── zshenv         # Environment variables
│   │   └── zshrc          # Main Zsh configuration
│   ├── wezterm/           # Wezterm terminal configuration
│   │   ├── wezterm.lua    # Main Wezterm config
│   │   └── README.md      # Wezterm documentation
│   ├── kitty/            # Kitty terminal configuration
│   │   ├── kitty.conf    # Main Kitty config
│   │   └── README.md     # Kitty documentation
│   └── [app_configs]/     # Application-specific configs
├── Makefile              # Automation tasks
├── .gitignore           # Git exclusions
└── .cursorignore        # Cursor indexing exclusions
```

## Features

- XDG Base Directory Specification compliant
- Modular Zsh configuration
- Automated setup and deployment
- Version-controlled configuration management
- Security-focused design
- Terminal emulator configurations
  - Wezterm (GPU-accelerated)
  - Kitty (GPU-accelerated)

## Usage

### Prerequisites

- Zsh shell
- Git
- Make
- Terminal emulators (optional):
  - Wezterm
  - Kitty

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/config_repo.git
   ```

2. Run the setup:
   ```bash
   make setup
   ```

### Common Tasks

- `make setup`: Initial setup of configurations
- `make deploy`: Deploy configurations to system
- `make backup`: Backup existing configurations
- `make clean`: Clean generated files
- `make lint`: Lint configuration files
- `make test`: Test configurations

## Adding New Configurations

1. Create a new directory under `xdg_config/`
2. Add configuration files
3. Update the Makefile if needed
4. Document the changes

## Security

- Sensitive data should be stored in environment variables
- Use `.gitignore` to exclude private configurations
- Employ encryption for sensitive data when necessary

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License
