# Solarized Light (Fixed)

A refined **Solarized Light** theme for VS Code with **readable text in Extensions view, tabs, lists, and panels**.

## Problem

The standard Solarized Light theme renders extension names, descriptions, tabs, and sidebar text in a very light grey that's hard to read. This theme fixes that issue by ensuring all UI text uses Solarized Light's base text color (`#657b83`).

## What's Fixed

- **Extensions view**: Extension names, descriptions, download counts, and tabs are now clearly visible.
- **Tabs**: Active and inactive tab text is fully readable.
- **Lists & Trees**: File explorer, search results, and other lists have proper contrast.
- **Sidebars**: Activity bar and side panel text is no longer faint.
- **Menus & Panels**: All UI elements maintain consistent, readable text color.

## Installation

### From VS Code Marketplace (once published)

1. Open **Extensions** view (`Cmd+Shift+X` on macOS, `Ctrl+Shift+X` on Windows/Linux).
2. Search for **"Solarized Light (Fixed)"**.
3. Click **Install**.
4. Select it as your active theme: **Preferences** → **Color Theme** → **Solarized Light (Fixed)**.

### Manual Installation (during development)

1. Clone or download this repo to `~/.vscode/extensions/vscode-solarized-light-fixed-1.0.0/`.
2. Reload VS Code.
3. Select the theme from **Preferences** → **Color Theme** → **Solarized Light (Fixed)**.

## Features

- Based on the original [Solarized Light](https://ethanschoonover.com/solarized/) palette.
- Proper UI color customizations for all text-heavy UI areas.
- Light, warm background (`#fdf6e3`) that's easy on the eyes.
- Consistent, accessible text contrast throughout.

## Publishing

To publish updates to the VS Code Marketplace, use [vsce](https://github.com/microsoft/vscode-vsce):

```bash
npm install -g vsce
vsce publish
```

(See [Publishing Extensions](https://code.visualstudio.com/api/working-with-extensions/publishing-extension) for full details and publisher setup.)

## License

MIT

## Quick Apply Script

The `apply-theme-colors.js` script allows you to quickly apply the theme colors directly to your VS Code `settings.json` file without installing the theme extension.

### Standard Solarized Palette

```
Base colors:
- base03: #002b36
- base02: #073642
- base01: #586e75
- base00: #657b83
- base0:  #839496
- base1:  #93a1a1
- base2:  #eee8d5
- base3:  #fdf6e3

Accent colors:
- yellow:  #b58900
- orange:  #cb4b16
- red:     #dc322f
- magenta: #d33682
- violet:  #6c71c4
- blue:    #268bd2
- cyan:    #2aa198
- green:   #859900
```

### Usage

```bash
node apply-theme-colors.js
```

This will:
1. Read the theme colors from `themes/solarized-light-fixed.json`
2. Create a backup of your current settings
3. Apply all color customizations to your `settings.json`
4. Apply token color customizations

## Credits

Theme colors based on [Solarized by Ethan Schoonover](https://ethanschoonover.com/solarized/).
Fixes by [Your Name].
