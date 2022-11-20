#!/usr/bin/env fish

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

# Allow users to optionally configure their fzf plugin path and set the
# value if one doesn't exist. This runs each time a script is switched
# so it's important to check for previously set values.

if test -z "$BASE16_FZF_PATH"
  set -g BASE16_FZF_PATH "$HOME/.config/base16-fzf"
end

# If BASE16_FZF_PATH doesn't exist, stop hook
if not test -d "$BASE16_FZF_PATH"
  exit 2
end

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"

# If base16-fzf is used, provide a file for base16-fzf to source
if test -e "$BASE16_FZF_PATH/fish/base16-$current_theme_name.fish"
  source "$BASE16_FZF_PATH/fish/base16-$current_theme_name.fish"
else
  set output (string join ' ' \
   "'$current_theme_name' theme could not be found."
   "Make sure '$BASE16_FZF_PATH' is running the most up-to-date" \
   "version by doing a 'git pull' in the repository directory.")

  echo $output
end
