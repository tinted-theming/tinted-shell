#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

DELTA_GITCONFIG_PATH="$BASE16_CONFIG_PATH/delta.gitconfig"

if [ -f "$DELTA_GITCONFIG_PATH" ]; then
  touch "$DELTA_GITCONFIG_PATH"
fi

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

if [[ -z $BASE16_COLOR_00_HEX ]]; then
  # BASE16_SHELL_ENABLE_VARS not set.
  return
fi

read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"

# Determine if theme is dark or light based on HSP calculation:
# http://alienryderflex.com/hsp.html

# We'll calculate the "perceived brightness" of the theme's background color.
# We will use `bc`, and it only understands upper-case hex values:
current_bg_color=$(echo $BASE16_COLOR_00_HEX | tr '[:lower:]' '[:upper:]')

r_hex_value=${current_bg_color:0:2}
g_hex_value=${current_bg_color:2:2}
b_hex_value=${current_bg_color:4:2}

# Calculate the perceived brightness, and check against brightness threshold of 7F.8 (127.5 in decimal):
echo "ibase=16; sqrt((.4C8 * ${r_hex_value} ^ 2) + (0.964 * ${g_hex_value} ^ 2) + (.1D2 * ${b_hex_value} ^ 2)) > 7F.8" | bc | read hsp

is_light_theme="false"
if [[ $hsp == "1" ]]; then
  is_light_theme="true"
fi

gitconfig_output="# vim: ft=gitconfig\n"
gitconfig_output+="[delta]\n"
gitconfig_output+="\tlight = ${is_light_theme}"

echo -e "$gitconfig_output" >| "$DELTA_GITCONFIG_PATH"
