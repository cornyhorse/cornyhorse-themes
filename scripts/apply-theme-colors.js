#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const os = require('os');

// Standard Solarized color palette
const SOLARIZED_COLORS = {
  base03: '#002b36',
  base02: '#073642',
  base01: '#586e75',
  base00: '#657b83',
  base0: '#839496',
  base1: '#93a1a1',
  base2: '#eee8d5',
  base3: '#fdf6e3',
  yellow: '#b58900',
  orange: '#cb4b16',
  red: '#dc322f',
  magenta: '#d33682',
  violet: '#6c71c4',
  blue: '#268bd2',
  cyan: '#2aa198',
  green: '#859900'
};

// Determine VS Code settings path based on OS
function getSettingsPath() {
  const platform = os.platform();
  let settingsDir;
  
  if (platform === 'darwin') {
    settingsDir = path.join(os.homedir(), 'Library', 'Application Support', 'Code', 'User');
  } else if (platform === 'win32') {
    settingsDir = path.join(process.env.APPDATA, 'Code', 'User');
  } else {
    settingsDir = path.join(os.homedir(), '.config', 'Code', 'User');
  }
  
  return path.join(settingsDir, 'settings.json');
}

// Read the theme file
function readThemeFile() {
  const themePath = path.join(__dirname, 'themes', 'solarized-light-fixed.json');
  const themeContent = fs.readFileSync(themePath, 'utf8');
  return JSON.parse(themeContent);
}

// Apply theme colors to VS Code settings
function applyThemeColors() {
  const settingsPath = getSettingsPath();
  const theme = readThemeFile();
  
  console.log(`Reading VS Code settings from: ${settingsPath}`);
  
  // Read existing settings or create empty object
  let settings = {};
  if (fs.existsSync(settingsPath)) {
    const settingsContent = fs.readFileSync(settingsPath, 'utf8');
    // Remove comments from JSON (VS Code allows comments in settings.json)
    const cleanedContent = settingsContent.replace(/\/\/.*$/gm, '').replace(/\/\*[\s\S]*?\*\//g, '');
    try {
      settings = JSON.parse(cleanedContent);
    } catch (e) {
      console.error('Error parsing settings.json, creating backup...');
      fs.copyFileSync(settingsPath, settingsPath + '.backup');
      settings = {};
    }
  }
  
  // Create backup
  if (fs.existsSync(settingsPath)) {
    const backupPath = settingsPath + '.backup.' + Date.now();
    fs.copyFileSync(settingsPath, backupPath);
    console.log(`Backup created: ${backupPath}`);
  }
  
  // Apply workbench colors from theme
  if (!settings['workbench.colorCustomizations']) {
    settings['workbench.colorCustomizations'] = {};
  }
  
  // Copy all colors from theme
  Object.assign(settings['workbench.colorCustomizations'], theme.colors);
  
  // Apply token colors
  if (theme.tokenColors && theme.tokenColors.length > 0) {
    if (!settings['editor.tokenColorCustomizations']) {
      settings['editor.tokenColorCustomizations'] = {};
    }
    if (!settings['editor.tokenColorCustomizations'].textMateRules) {
      settings['editor.tokenColorCustomizations'].textMateRules = [];
    }
    
    // Replace or add token color rules
    settings['editor.tokenColorCustomizations'].textMateRules = theme.tokenColors.map(rule => ({
      scope: rule.scope,
      settings: rule.settings
    }));
  }
  
  // Write updated settings
  const settingsJson = JSON.stringify(settings, null, 2);
  fs.writeFileSync(settingsPath, settingsJson, 'utf8');
  
  console.log('✓ Theme colors applied successfully!');
  console.log('  Colors applied:', Object.keys(theme.colors).length);
  console.log('  Token rules applied:', theme.tokenColors ? theme.tokenColors.length : 0);
  console.log('\nRestart VS Code or reload the window to see the changes.');
}

// Main execution
try {
  applyThemeColors();
} catch (error) {
  console.error('Error applying theme colors:', error.message);
  process.exit(1);
}
