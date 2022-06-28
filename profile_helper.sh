#!/usr/bin/env bash

BASE16_CONFIG_PATH="$HOME/.config/base16-project"
BASE16_SHELL_COLORSCHEME_PATH="$BASE16_CONFIG_PATH/base16_shell_theme"
BASE16_SHELL_TMUXCONF_PATH="$BASE16_CONFIG_PATH/tmux.base16.conf"
BASE16_TMUX_PLUGIN_PATH="$HOME/.tmux/plugins/base16-tmux"

if [ ! -d "$BASE16_CONFIG_PATH" ]; then
  mkdir -p "$BASE16_CONFIG_PATH"
fi

if [ -z "$BASE16_SHELL_PATH" ]; then
  if [ -n "$BASH_VERSION" ]; then
    script_path=${BASH_SOURCE[0]}
  elif [ -n "$ZSH_VERSION" ]; then
    script_path=${(%):-%x}
  fi

  BASE16_SHELL_PATH=${script_path%/*}
fi

_base16()
{
  local script=$1
  local theme=$2
  [ -f "$script" ] && . $script
  ln -fs $script "$BASE16_SHELL_COLORSCHEME_PATH"

  # If base16-tmux is used, provide a file to source when the theme
  # changes
  if [ -e "$BASE16_TMUX_PLUGIN_PATH" ]; then 
    echo -e "set -g \0100colors-base16 '$theme'" >| \
      "$BASE16_SHELL_TMUXCONF_PATH"
  fi

  if [ -n ${BASE16_SHELL_HOOKS:+s} ] \
    && [ -d "${BASE16_SHELL_HOOKS}" ]; then
    for hook in $BASE16_SHELL_HOOKS/*; do
      [ -f "$hook" ] && [ -x "$hook" ] && "$hook"
    done
  fi
}

if [ -n "$BASE16_THEME_DEFAULT" ] \
  && [ ! -e "$BASE16_SHELL_COLORSCHEME_PATH" ]; then
  ln -s \
    "$BASE16_SHELL_PATH/scripts/base16-$BASE16_THEME_DEFAULT.sh" \
    "$BASE16_SHELL_COLORSCHEME_PATH"
fi

if [ -e "$BASE16_SHELL_COLORSCHEME_PATH" ]; then
  . "$BASE16_SHELL_COLORSCHEME_PATH"
fi

# Set base16_* aliases
for script in "$BASE16_SHELL_PATH"/scripts/base16*.sh; do
  script_name=${script##*/}
  script_name=${script_name%.sh}
  theme=${script_name#*-}
  func_name="base16_${theme}"
  alias $func_name="_base16 \"${script}\" ${theme}"
done;

alias reset="command reset \
  && [ -f $BASE16_SHELL_COLORSCHEME_PATH ] \
  && . $BASE16_SHELL_COLORSCHEME_PATH"
