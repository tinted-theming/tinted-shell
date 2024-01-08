#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

BASE16_SHELL_VIM_PATH="$BASE16_CONFIG_PATH/set_theme.vim"
BASE16_SHELL_NVIM_PATH="$BASE16_CONFIG_PATH/set_theme.lua"

if ! [ -e "$BASE16_SHELL_VIM_PATH" ]; then
  touch "$BASE16_SHELL_VIM_PATH"
fi

if ! [ -e "$BASE16_SHELL_NVIM_PATH" ]; then
  touch "$BASE16_SHELL_NVIM_PATH"
fi

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------
read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"

cat > "$BASE16_SHELL_VIM_PATH" << EOF
if !exists('g:colors_name') || g:colors_name != 'base16-$current_theme_name'
  colorscheme base16-$current_theme_name
endif
EOF

cat > "$BASE16_SHELL_NVIM_PATH" << EOF
local current_theme_name = "$current_theme_name"
if current_theme_name ~= "" and vim.g.colors_name ~= 'base16-' .. current_theme_name then
  vim.cmd('colorscheme base16-' .. current_theme_name)
end
EOF
