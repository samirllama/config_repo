# Wezterm Configuration

This directory contains configuration for [Wezterm](https://wezfurlong.org/wezterm/), a GPU-accelerated terminal emulator.

## Files

- `wezterm.lua` - Main configuration file

## Features

- Catppuccin Mocha color scheme
- JetBrainsMono Nerd Font configuration
- Custom window opacity and blur settings
- Background image support
- Custom key bindings
  - `Ctrl+f`: Toggle fullscreen
  - `Ctrl+'`: Clear scrollback
- Mouse bindings for URL handling

## Dependencies

- JetBrainsMono Nerd Font
- Catppuccin Mocha color scheme (built into Wezterm)

## Installation

The configuration will be automatically deployed to `~/.config/wezterm/` when running:

```bash
make deploy
```

## Manual Installation

If you prefer to install manually:

```bash
mkdir -p ~/.config/wezterm
ln -sf $(pwd)/wezterm.lua ~/.config/wezterm/wezterm.lua
```

## Customization

### Background Image

Current background image path:

```lua
config.window_background_image = "/Users/apex/Downloads/5_artsy_samu.jpg"
```

Update this path to your preferred image.

### Opacity and Blur

Current settings:

- Window opacity: 50%
- Blur effect: 82 (macOS only)

Adjust these values in `wezterm.lua`:

```lua
config.window_background_opacity = 0.50
config.macos_window_background_blur = 82
```
