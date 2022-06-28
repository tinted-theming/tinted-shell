#!/usr/bin/env fish

# [what] provides aliases for base16 themes and sets
# $HOME/.config/base16-project/base16_shell_theme
#
# [usage] can be added to $HOME/.config/fish/config.fish like so:
#
# if status --is-interactive
#    source $HOME/.config/base16-shell/profile_helper.fish
# end
#
# TODO: maybe port to $HOME/.config/fish/functions ?

set BASE16_CONFIG_PATH "$HOME/.config/base16-project"
set BASE16_SHELL_COLORSCHEME_PATH "$BASE16_CONFIG_PATH/base16_shell_theme"
set BASE16_SHELL_TMUXCONF_PATH "$BASE16_CONFIG_PATH/tmux.base16.conf"
set BASE16_TMUX_PLUGIN_PATH "$HOME/.tmux/plugins/base16-tmux"


if test -z $BASE16_SHELL_PATH
  set -g BASE16_SHELL_PATH (cd (dirname (status -f)); and pwd)
end

# Load the active theme
if test -e $BASE16_SHELL_COLORSCHEME_PATH
  sh $BASE16_SHELL_COLORSCHEME_PATH
end

if test -n "$BASE16_THEME_DEFAULT"; and not test -e $BASE16_SHELL_COLORSCHEME_PATH
  ln -s "$BASE16_SHELL_PATH/scripts/base16-$BASE16_THEME_DEFAULT.sh" \
    $BASE16_SHELL_COLORSCHEME_PATH
end

# Set base16-* aliases
for SCRIPT in $BASE16_SHELL_PATH/scripts/*.sh
  set THEME (basename $SCRIPT .sh)
  function $THEME -V SCRIPT -V THEME
    set partial_theme_name (string replace -a 'base16-' '' $THEME) # eg: ocean
    sh $SCRIPT
    ln -sf $SCRIPT $BASE16_SHELL_COLORSCHEME_PATH
    # If base16-tmux is used, provide a file to source when the theme changes
    if test -e "$BASE16_TMUX_PLUGIN_PATH"
      echo "set -g @colors-base16 '$partial_theme_name'" > "$BASE16_SHELL_TMUXCONF_PATH"
    end

    if test (count $BASE16_SHELL_HOOKS) -eq 1; and test -d "$BASE16_SHELL_HOOKS"
      for hook in $BASE16_SHELL_HOOKS/*
        test -f "$hook"; and test -x "$hook"; and "$hook"
      end
    end
  end
end

alias reset "command reset \
  && [ -f $BASE16_SHELL_COLORSCHEME_PATH ] \
  && sh $BASE16_SHELL_COLORSCHEME_PATH"
