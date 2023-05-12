#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

# Allow users to optionally configure where their base16-shell config is
# stored by specifying BASE16_CONFIG_PATH before loading this script
if [ -z $BASE16_CONFIG_PATH ]; then
  BASE16_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming"
fi
BASE16_SHELL_COLORSCHEME_PATH="$BASE16_CONFIG_PATH/base16_shell_theme"
# Store the theme name in a file so we aren't reliant on environment
# variables to store this value alone since it can be inaccurate when
# using session managers such as TMUX
BASE16_SHELL_THEME_NAME_PATH="$BASE16_CONFIG_PATH/theme_name" 

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

# If the user hasn't specified a hooks dir path or it is invalid, use
# the existing path
if [ -z "$BASE16_SHELL_HOOKS_PATH" ] && [ ! -d "$BASE16_SHELL_HOOKS_PATH" ]; then
  BASE16_SHELL_HOOKS_PATH="$BASE16_SHELL_PATH/hooks"
fi

# Create the config path if the path doesn't currently exist
if [ ! -d "$BASE16_CONFIG_PATH" ]; then
  mkdir -p "$BASE16_CONFIG_PATH";
fi

# Create a file containing the current theme name
if [ ! -e "$BASE16_SHELL_THEME_NAME_PATH" ]; then
  touch "$BASE16_SHELL_THEME_NAME_PATH";
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

  if [ -f "$BASE16_SHELL_THEME_NAME_PATH" ]; then
    echo "$theme_name" >| "$BASE16_SHELL_THEME_NAME_PATH";
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

  if [ -d "${BASE16_SHELL_HOOKS_PATH}" ]; then
    for hook in $BASE16_SHELL_HOOKS_PATH/*.sh; do
      [ -x "$hook" ] && . "$hook"
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
  theme_name=${script_name#base16-} # eg: solarized-light
  function_name="base16_${theme_name}"

  alias $function_name="set_theme \"${theme_name}\""
done;

# unset loop variables to not leak to user's shell
unset script_path script_name theme_name function_name

# If $BASE16_THEME is set, this has already been loaded. This guards
# against a bug where this script is sourced two or more times.
if [ -n "$BASE16_THEME" ]; then
  return 0
fi

# Load the active theme
# If the theme name can be easily retrieved
read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"
if [ -n "$current_theme_name" ]; then
  set_theme "$current_theme_name"
# Else extract from the colorscheme file
elif [ -e "$BASE16_SHELL_COLORSCHEME_PATH" ]; then
  # Get the active theme name from the export variable in the script
  current_theme_name=$(grep 'export BASE16_THEME' "$BASE16_SHELL_COLORSCHEME_PATH")
  current_theme_name=${current_theme_name#*=}
  set_theme "$current_theme_name"
# If a colorscheme file doesn't exist and BASE16_THEME_DEFAULT is set,
# then create the colorscheme file based on the BASE16_THEME_DEFAULT
# scheme name
elif [ -n "$BASE16_THEME_DEFAULT" ]; then
  set_theme "$BASE16_THEME_DEFAULT"
fi
