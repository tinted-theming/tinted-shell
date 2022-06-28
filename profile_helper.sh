#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

BASE16_CONFIG_PATH="$HOME/.config/base16-project"
BASE16_SHELL_COLORSCHEME_PATH="$BASE16_CONFIG_PATH/base16_shell_theme"
BASE16_SHELL_TMUXCONF_PATH="$BASE16_CONFIG_PATH/tmux.base16.conf"
BASE16_TMUX_PLUGIN_PATH="$HOME/.tmux/plugins/base16-tmux"

# Allow users to optionally configure their base16-shell path and set
# the value if one doesn't exist
if [ -z "$BASE16_SHELL_PATH" ]; then
  if [ -n "$BASH_VERSION" ]; then
    script_path=${BASH_SOURCE[0]}
  elif [ -n "$ZSH_VERSION" ]; then
    script_path=${(%):-%x}
  fi

  BASE16_SHELL_PATH=${script_path%/*}
fi

# Allow users to optionally configure their tmux plugin path and set
# the value if one doesn't exist
if [ -z "$BASE16_TMUX_PLUGIN_PATH" ]; then
  BASE16_TMUX_PLUGIN_PATH="$HOME/.tmux/plugins/base16-tmux"
fi

# Create the config path if the path doesn't currently exist
if [ ! -d "$BASE16_CONFIG_PATH" ]; then
  mkdir -p "$BASE16_CONFIG_PATH"
fi

# ----------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------

set_theme()
{
  local theme_name=$1
  local script_path="$BASE16_SHELL_PATH/scripts/base16-$theme_name.sh"

  if [ ! -e $BASE16_CONFIG_PATH ]; then
    echo "\$BASE16_CONFIG_PATH doesn't exist. Try sourcing this script \
      and then try again"
    return 2
  fi

  if [ -z $theme_name ]; then
    echo "Provide a theme name to set_theme or ensure \
      \$BASE16_THEME_DEFAULT is set"
    return 1
  fi

  # Symlink new colorscheme
  ln -fs "$script_path" "$BASE16_SHELL_COLORSCHEME_PATH"
  if [ ! -e "$BASE16_SHELL_COLORSCHEME_PATH" ]; then
    echo "Attempted symbolic link failed. Ensure \$BASE16_SHELL_PATH \
      and \$BASE16_SHELL_COLORSCHEME_PATH are valid paths."
    return 2
  fi

  # Source newly symlinked file
  [ -f "$BASE16_SHELL_COLORSCHEME_PATH" ] \
    && . "$BASE16_SHELL_COLORSCHEME_PATH"

  # If base16-tmux is used, provide a file for base16-tmux to source
  if [ -e "$BASE16_TMUX_PLUGIN_PATH" ]; then 
    echo -e "set -g \0100colors-base16 '$theme_name'" >| \
      "$BASE16_SHELL_TMUXCONF_PATH"
  fi

  if [ -n ${BASE16_SHELL_HOOKS:+s} ] \
    && [ -d "${BASE16_SHELL_HOOKS}" ]; then
    for hook in $BASE16_SHELL_HOOKS/*; do
      [ -f "$hook" ] && [ -x "$hook" ] && "$hook"
    done
  fi
}

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

# Reload the $BASE16_SHELL_COLORSCHEME_PATH when the shell is reset
alias reset="command reset \
  && [ -f $BASE16_SHELL_COLORSCHEME_PATH ] \
  && . $BASE16_SHELL_COLORSCHEME_PATH"

# Set base16_* aliases
for script_path in "$BASE16_SHELL_PATH"/scripts/base16*.sh; do
  script_name=${script_path##*/}
  script_name=${script_name%.sh}
  theme_name=${script_name#*-} # eg: solarized-light
  function_name="base16_${theme_name}"

  alias $function_name="set_theme \"${theme_name}\""
done;

# Load the active theme
if [ -e "$BASE16_SHELL_COLORSCHEME_PATH" ]; then
  # Get the active theme name from the export variable in the script
  current_theme_name=$(grep -P 'export BASE16_THEME' "$BASE16_SHELL_COLORSCHEME_PATH")
  current_theme_name=${current_theme_name#*=}
  set_theme "$current_theme_name"
# If a colorscheme file doesn't exist and BASE16_THEME_DEFAULT is set,
# then create the colorscheme file based on the BASE16_THEME_DEFAULT
# scheme name
elif [ -n "$BASE16_THEME_DEFAULT" ]; then
  set_theme "$BASE16_THEME_DEFAULT"
fi
