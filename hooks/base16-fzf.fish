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
  return 2
end

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

# If base16-fzf is used, provide a file for base16-fzf to source
if test -e "$BASE16_FZF_PATH/fish/base16-$BASE16_THEME.fish"
  source "$BASE16_FZF_PATH/fish/base16-$BASE16_THEME.fish"
else
  set output $(string join ' ' \
   "\$BASE16_FZF_PATH doesn't seem to be a clone of the " \
   "base16-fzf GitHub repository.")
  echo $output
end
