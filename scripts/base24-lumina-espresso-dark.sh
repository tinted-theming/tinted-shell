#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Espresso Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-espresso-dark"

color00="2f/1d/11" # Base 00 - Black
color01="d4/71/69" # Base 08 - Red
color02="92/c7/9c" # Base 0B - Green
color03="fd/cf/90" # Base 0A - Yellow
color04="92/bb/ea" # Base 0D - Blue
color05="b6/af/e8" # Base 0E - Magenta
color06="b7/dc/e5" # Base 0C - Cyan
color07="e5/db/cd" # Base 05 - White
color08="4b/35/27" # Base 03 - Bright Black
color09="e1/93/8b" # Base 12 - Bright Red
color10="aa/e1/b5" # Base 14 - Bright Green
color11="ff/e3/be" # Base 13 - Bright Yellow
color12="b0/d5/ff" # Base 16 - Bright Blue
color13="ef/ad/d2" # Base 17 - Bright Magenta
color14="be/f2/ff" # Base 15 - Bright Cyan
color15="e5/db/cd" # Base 07 - Bright White
color16="ff/be/92" # Base 09
color17="dc/8e/bb" # Base 0F
color18="35/21/14" # Base 01
color19="40/2b/1d" # Base 02
color20="86/6e/5c" # Base 04
color21="be/ad/a3" # Base 06
color_foreground="e5/db/cd" # Base 05
color_background="2f/1d/11" # Base 00


if [ -z "$TTY" ] && ! TTY=$(tty) || [ ! -w "$TTY" ]; then
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

# 256 color space
put_template 16 "$color16"
put_template 17 "$color17"
put_template 18 "$color18"
put_template 19 "$color19"
put_template 20 "$color20"
put_template 21 "$color21"

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg e5dbcd # foreground
  put_template_custom Ph 2f1d11 # background
  put_template_custom Pi e5dbcd # bold color
  put_template_custom Pj 402b1d # selection color
  put_template_custom Pk e5dbcd # selected text color
  put_template_custom Pl e5dbcd # cursor
  put_template_custom Pm 2f1d11 # cursor text
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
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background

# Optionally export variables
if [ -n "$TINTED_SHELL_ENABLE_BASE24_VARS" ]; then
  export BASE24_COLOR_00_HEX="2f1d11"
  export BASE24_COLOR_01_HEX="352114"
  export BASE24_COLOR_02_HEX="402b1d"
  export BASE24_COLOR_03_HEX="4b3527"
  export BASE24_COLOR_04_HEX="866e5c"
  export BASE24_COLOR_05_HEX="e5dbcd"
  export BASE24_COLOR_06_HEX="beada3"
  export BASE24_COLOR_07_HEX="e5dbcd"
  export BASE24_COLOR_08_HEX="d47169"
  export BASE24_COLOR_09_HEX="ffbe92"
  export BASE24_COLOR_0A_HEX="fdcf90"
  export BASE24_COLOR_0B_HEX="92c79c"
  export BASE24_COLOR_0C_HEX="b7dce5"
  export BASE24_COLOR_0D_HEX="92bbea"
  export BASE24_COLOR_0E_HEX="b6afe8"
  export BASE24_COLOR_0F_HEX="dc8ebb"
  export BASE24_COLOR_10_HEX="211208"
  export BASE24_COLOR_11_HEX="29170b"
  export BASE24_COLOR_12_HEX="e1938b"
  export BASE24_COLOR_13_HEX="ffe3be"
  export BASE24_COLOR_14_HEX="aae1b5"
  export BASE24_COLOR_15_HEX="bef2ff"
  export BASE24_COLOR_16_HEX="b0d5ff"
  export BASE24_COLOR_17_HEX="efadd2"
fi
