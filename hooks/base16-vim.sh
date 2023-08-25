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

vim_output="if !exists('g:colors_name') || g:colors_name != 'base16-$current_theme_name'\n"
vim_output+="  colorscheme base16-$current_theme_name\n"
vim_output+="endif"

nvim_output="local current_theme_name = \"$current_theme_name\"\n"
nvim_output+="if current_theme_name ~= \"\" and vim.g.colors_name ~= 'base16-' .. current_theme_name then\n"
nvim_output+="  vim.cmd('colorscheme base16-' .. current_theme_name)\n"
nvim_output+="end"

echo -e "$vim_output" >| "$BASE16_SHELL_VIM_PATH"
echo -e "$nvim_output" >| "$BASE16_SHELL_NVIM_PATH"
