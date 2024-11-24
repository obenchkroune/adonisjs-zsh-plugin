# AdonisJS ZSH Plugin

A ZSH plugin that provides command completion and convenience functions for working with AdonisJS projects.

## Features

- Auto-detection of AdonisJS projects
- Command completion for ace CLI commands
- Path traversal to find ace binary

## Installation

1. Add the plugin to your ZSH configuration:

### Using Oh My Zsh

```bash
git clone https://github.com/obenchkroune/adonis-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/adonis
```

Then add `adonis` to your plugin list in `.zshrc`:

```bash
plugins=(... adonis)
```

### Manual Installation

```bash
git clone https://github.com/obenchkroune/adonis-zsh-plugin.git
source /path/to/adonis-zsh-plugin/adonis.plugin.zsh
```
