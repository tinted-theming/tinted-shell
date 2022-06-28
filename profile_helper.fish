#!/usr/bin/env fish

# ----------------------------------------------------------------------
# Setup variables and env
# ----------------------------------------------------------------------

set BASE16_CONFIG_PATH "$HOME/.config/base16-project"
set BASE16_SHELL_COLORSCHEME_PATH \
  "$BASE16_CONFIG_PATH/base16_shell_theme"
set BASE16_SHELL_TMUXCONF_PATH "$BASE16_CONFIG_PATH/tmux.base16.conf"
set BASE16_TMUX_PLUGIN_PATH "$HOME/.tmux/plugins/base16-tmux"

# Allow users to optionally configure their base16-shell path and set
# the value if one doesn't exist
if test -z $BASE16_SHELL_PATH
  set -g BASE16_SHELL_PATH (cd (dirname (status -f)); and pwd)
end

# Allow users to optionally configure their tmux plugin path and set
# the value if one doesn't exist
if test -z $BASE16_TMUX_PLUGIN_PATH
  set BASE16_TMUX_PLUGIN_PATH "$HOME/.tmux/plugins/base16-tmux"
end

# Create the config path if the path doesn't currently exist
if not test -d "$BASE16_CONFIG_PATH"
  mkdir -p "$BASE16_CONFIG_PATH"
end

# ----------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------

function set_theme
  set theme_name $argv[1]

  if not test -e $BASE16_CONFIG_PATH
    echo "\$BASE16_CONFIG_PATH doesn't exist. Try sourcing this script \
      and then try again"
    return 2
  end

  if test -z $theme_name
    echo "Provide a theme name to set_theme or ensure \
      \$BASE16_THEME_DEFAULT is set"
    return 1
  end

  # Symlink and source
  ln -fs \
    "$BASE16_SHELL_PATH/scripts/base16-$theme_name.sh" \
    "$BASE16_SHELL_COLORSCHEME_PATH"
  if not test -e "$BASE16_SHELL_COLORSCHEME_PATH"
    echo "Attempted symbolic link failed. Ensure \$BASE16_SHELL_PATH \
    and \$BASE16_SHELL_COLORSCHEME_PATH are valid paths."
    return 2
  end

  # Source newly symlinked file
  if test -f "$BASE16_SHELL_COLORSCHEME_PATH"
    sh $BASE16_SHELL_COLORSCHEME_PATH

    # Env variables aren't globally set when bash shell is sourced
    set -g BASE16_THEME "$theme_name"
  end

  # If base16-tmux is used, provide a file for base16-tmux to source
  if test -e "$BASE16_TMUX_PLUGIN_PATH"
    echo "set -g @colors-base16 '$theme_name'" > \
      "$BASE16_SHELL_TMUXCONF_PATH"
  end

  if test (count $BASE16_SHELL_HOOKS) -eq 1; and test -d "$BASE16_SHELL_HOOKS"
    for hook in $BASE16_SHELL_HOOKS/*
      test -f "$hook"; and test -x "$hook"; and "$hook"
    end
   end
end

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

# Reload the $BASE16_SHELL_COLORSCHEME_PATH when the shell is reset
alias reset "command reset \
  && [ -f $BASE16_SHELL_COLORSCHEME_PATH ] \
  && sh $BASE16_SHELL_COLORSCHEME_PATH"

# Set base16-* aliases
for script_path in $BASE16_SHELL_PATH/scripts/*.sh
  set function_name (basename $script_path .sh)
  set theme_name (string replace -a 'base16-' '' $function_name) 

  alias $function_name="set_theme \"$theme_name\""
end

# Load the active theme
if test -e "$BASE16_SHELL_COLORSCHEME_PATH"
  # Get the active theme name from the export variable in the script
  set current_theme_name \
    $(grep -P 'export BASE16_THEME' "$BASE16_SHELL_COLORSCHEME_PATH")
  set current_theme_name \
    $(string replace -r 'export BASE16_THEME=' '' $current_theme_name)
  set_theme "$current_theme_name"
# If a colorscheme file doesn't exist and BASE16_THEME_DEFAULT is set,
# then create the colorscheme file based on the BASE16_THEME_DEFAULT
# scheme name
else if test -n "$BASE16_THEME_DEFAULT"
  set_theme "$BASE16_THEME_DEFAULT"
end
