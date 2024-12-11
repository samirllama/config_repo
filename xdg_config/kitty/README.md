# Kitty Terminal Configuration

This directory contains configuration for [Kitty](https://sw.kovidgoyal.net/kitty/), a fast, feature-rich, GPU based terminal emulator.

## Files

- `kitty.conf` - Main configuration file

## Features

- JetBrainsMono Nerd Font configuration
- Custom font settings for regular, bold, and italic variants
- Disabled audio bell
- Dynamic background opacity
- Custom key bindings
  - Disabled potentially dangerous shortcuts (ctrl+shift+q, ctrl+shift+w)
  - Line number hints for nvim integration
  - Custom search functionality
- Custom background color (#282c34)

## Dependencies

- JetBrainsMono Nerd Font family
  - Regular
  - Bold
  - Italic
  - Bold Italic
- Kitty kittens (built-in)
  - hints
  - search

## Installation

The configuration will be automatically deployed to `~/.config/kitty/` when running:

```bash
make deploy
```

## Manual Installation

If you prefer to install manually:

```bash
mkdir -p ~/.config/kitty
ln -sf $(pwd)/kitty.conf ~/.config/kitty/kitty.conf
```

## Customization

### Font Configuration

Current font settings:

```conf
font_family JetBrainsMono Nerd Font Mono Regular
bold_font JetBrainsMono Nerd Font Mono Bold
italic_font JetBrainsMono Nerd Font Mono Italic
bold_italic_font JetBrainsMono Nerd Font Mono Bold Italic
```

### Background and Opacity

```conf
background #282c34
dynamic_background_opacity true
```

### Key Bindings

Custom key bindings include:

- Line number hints for nvim integration
- Custom word definition lookup
- Integrated search functionality

## Additional Features

### Ligature Support

```conf
disable_ligatures never
```

### Monitor Sync

```conf
sync_to_monitor no
```

### Safety Features

Disabled potentially dangerous shortcuts:

```conf
map ctrl+shift+q noop
map ctrl+shift+w noop
```
