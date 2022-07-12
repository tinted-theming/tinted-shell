#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

# Allow users to optionally configure their fzf plugin path and set the
# value if one doesn't exist. This runs each time a script is switched
# so it's important to check for previously set values.

if [ -z "$BASE16_FZF_PATH" ]; then
  BASE16_FZF_PATH="$HOME/.config/base16-fzf"
fi

# If BASE16_FZF_PATH doesn't exist, stop hook
if [ ! -d "$BASE16_FZF_PATH" ]; then
  return 2
fi

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

# If base16-fzf is used, provide a file for base16-fzf to source
if [ -e "$BASE16_FZF_PATH/bash/base16-$BASE16_THEME.config" ]; then 
  source "$BASE16_FZF_PATH/bash/base16-$BASE16_THEME.config"
else
  output="'$BASE16_THEME' theme could not be found. "
  output+="Make sure '$BASE16_FZF_PATH' is running the most up-to-date "
  output+="version by doing a 'git pull' in the repository directory."
  echo $output
fi
