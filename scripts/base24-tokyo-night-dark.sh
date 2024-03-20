#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Tokyo Night Dark 
# Scheme author: Jamy Golden (https://github.com/JamyGolden)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="tokyo-night-dark"

color00="41/48/68" # Base 00 - Black
color01="f7/76/8e" # Base 08 - Red
color02="9e/ce/6a" # Base 0B - Green
color03="e0/af/68" # Base 09 - Yellow
color04="7d/cf/ff" # Base 0D - Blue
color05="bb/9a/f7" # Base 0E - Magenta
color06="73/da/ca" # Base 0C - Cyan
color07="9a/b1/d6" # Base 06 - White
color08="54/5c/7e" # Base 02 - Bright Black
color09="ff/00/7c" # Base 12 - Bright Red
color10="9e/ce/6a" # Base 14 - Bright Green
color11="ff/9e/64" # Base 13 - Bright Yellow
color12="2a/c3/de" # Base 16 - Bright Blue
color13="7a/a2/f7" # Base 17 - Bright Magenta
color14="b4/f9/f8" # Base 15 - Bright Cyan
color15="cb/d0/e6" # Base 07 - Bright White
color16="e0/af/68" # Base 09
color17="c5/3b/53" # Base 0F
color18="4b/51/70" # Base 01
color19="54/5c/7e" # Base 02
color20="78/7c/99" # Base 04
color21="a9/b1/d6" # Base 06
color_foreground="9a/a5/ce" # Base 05
color_background="41/48/68" # Base 00

if [ -n "$TMUX" ] || [ "${TERM%%[-.]*}" = "tmux" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' "$@"; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' "$@"; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' "$@"; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' "$@"; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' "$@"; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' "$@"; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ "$1" -lt 16 ] && printf "\e]P%x%s" "$1" "$(echo "$2" | sed 's/\///g')"; }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' "$@"; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' "$@"; }
  put_template_custom() { printf '\033]%s%s\033\\' "$@"; }
fi

# 16 color space
put_template 0  "$color00"
put_template 1  "$color01"
put_template 2  "$color02"
put_template 3  "$color03"
put_template 4  "$color04"
put_template 5  "$color05"
put_template 6  "$color06"
put_template 7  "$color07"
put_template 8  "$color08"
put_template 9  "$color09"
put_template 10 "$color10"
put_template 11 "$color11"
put_template 12 "$color12"
put_template 13 "$color13"
put_template 14 "$color14"
put_template 15 "$color15"

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg 9aa5ce # foreground
  put_template_custom Ph 414868 # background
  put_template_custom Pi 9aa5ce # bold color
  put_template_custom Pj 545c7e # selection color
  put_template_custom Pk 9aa5ce # selected text color
  put_template_custom Pl 9aa5ce # cursor
  put_template_custom Pm 414868 # cursor text
else
  put_template_var 10 "$color_foreground"
  if [ "$BASE24_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 "$color_background"
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 "$color_background" # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset put_template
unset put_template_var
unset put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color15
unset color_foreground
unset color_background

# Optionally export variables
if [ -n "$TINTED_SHELL_ENABLE_BASE24_VARS" ]; then
  export BASE24_COLOR_00_HEX="414868"
  export BASE24_COLOR_01_HEX="4b5170"
  export BASE24_COLOR_02_HEX="545c7e"
  export BASE24_COLOR_03_HEX="565f89"
  export BASE24_COLOR_04_HEX="787c99"
  export BASE24_COLOR_05_HEX="9aa5ce"
  export BASE24_COLOR_06_HEX="a9b1d6"
  export BASE24_COLOR_07_HEX="cbd0e6"
  export BASE24_COLOR_08_HEX="f7768e"
  export BASE24_COLOR_09_HEX="e0af68"
  export BASE24_COLOR_0A_HEX="ff9e64"
  export BASE24_COLOR_0B_HEX="9ece6a"
  export BASE24_COLOR_0C_HEX="73daca"
  export BASE24_COLOR_0D_HEX="7dcfff"
  export BASE24_COLOR_0E_HEX="bb9af7"
  export BASE24_COLOR_0F_HEX="c53b53"
  export BASE24_COLOR_10_HEX="24283b"
  export BASE24_COLOR_11_HEX="1a1b26"
  export BASE24_COLOR_12_HEX="ff007c"
  export BASE24_COLOR_13_HEX="ff9e64"
  export BASE24_COLOR_14_HEX="9ece6a"
  export BASE24_COLOR_15_HEX="b4f9f8"
  export BASE24_COLOR_16_HEX="2ac3de"
  export BASE24_COLOR_17_HEX="7aa2f7"
fi
