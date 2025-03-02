#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Hopscotch 
# Scheme author: FredHappyface (https://github.com/fredHappyface)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="hopscotch"

color00="32/29/31" # Base 00 - Black
color01="dd/46/4c" # Base 08 - Red
color02="8f/c1/3e" # Base 0B - Green
color03="98/94/98" # Base 0A - Yellow
color04="12/90/bf" # Base 0D - Blue
color05="c8/5e/7c" # Base 0E - Magenta
color06="14/9b/93" # Base 0C - Cyan
color07="b9/b5/b8" # Base 06 - White
color08="79/73/79" # Base 02 - Bright Black
color09="fd/8b/19" # Base 12 - Bright Red
color10="43/3b/42" # Base 14 - Bright Green
color11="5c/54/5b" # Base 13 - Bright Yellow
color12="98/94/98" # Base 16 - Bright Blue
color13="d5/d3/d5" # Base 17 - Bright Magenta
color14="b3/35/08" # Base 15 - Bright Cyan
color15="ff/ff/ff" # Base 07 - Bright White
color16="fd/cc/59" # Base 09
color17="6e/23/26" # Base 0F
color18="32/29/31" # Base 01
color19="79/73/79" # Base 02
color20="99/94/98" # Base 04
color21="b9/b5/b8" # Base 06
color_foreground="a9/a4/a8" # Base 05
color_background="32/29/31" # Base 00


if [ -z "$TTY" ] && ! TTY=$(tty); then
  put_template() { true; }
  put_template_var() { true; }
  put_template_custom() { true; }
elif [ -n "$TMUX" ] || [ "${TERM%%[-.]*}" = "tmux" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' "$@" > "$TTY"; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' "$@" > "$TTY"; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' "$@" > "$TTY"; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' "$@" > "$TTY"; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' "$@" > "$TTY"; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' "$@" > "$TTY"; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ "$1" -lt 16 ] && printf "\e]P%x%s" "$1" "$(echo "$2" | sed 's/\///g')" > "$TTY"; }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' "$@" > "$TTY"; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' "$@" > "$TTY"; }
  put_template_custom() { printf '\033]%s%s\033\\' "$@" > "$TTY"; }
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
  put_template_custom Pg a9a4a8 # foreground
  put_template_custom Ph 322931 # background
  put_template_custom Pi a9a4a8 # bold color
  put_template_custom Pj 797379 # selection color
  put_template_custom Pk a9a4a8 # selected text color
  put_template_custom Pl a9a4a8 # cursor
  put_template_custom Pm 322931 # cursor text
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
  export BASE24_COLOR_00_HEX="322931"
  export BASE24_COLOR_01_HEX="322931"
  export BASE24_COLOR_02_HEX="797379"
  export BASE24_COLOR_03_HEX="898388"
  export BASE24_COLOR_04_HEX="999498"
  export BASE24_COLOR_05_HEX="a9a4a8"
  export BASE24_COLOR_06_HEX="b9b5b8"
  export BASE24_COLOR_07_HEX="ffffff"
  export BASE24_COLOR_08_HEX="dd464c"
  export BASE24_COLOR_09_HEX="fdcc59"
  export BASE24_COLOR_0A_HEX="989498"
  export BASE24_COLOR_0B_HEX="8fc13e"
  export BASE24_COLOR_0C_HEX="149b93"
  export BASE24_COLOR_0D_HEX="1290bf"
  export BASE24_COLOR_0E_HEX="c85e7c"
  export BASE24_COLOR_0F_HEX="6e2326"
  export BASE24_COLOR_10_HEX="504c50"
  export BASE24_COLOR_11_HEX="282628"
  export BASE24_COLOR_12_HEX="fd8b19"
  export BASE24_COLOR_13_HEX="5c545b"
  export BASE24_COLOR_14_HEX="433b42"
  export BASE24_COLOR_15_HEX="b33508"
  export BASE24_COLOR_16_HEX="989498"
  export BASE24_COLOR_17_HEX="d5d3d5"
fi
