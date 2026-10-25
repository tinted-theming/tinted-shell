#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Rayleigh Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-rayleigh-dark"

color00="14/18/2c" # Base 00 - Black
color01="da/6d/65" # Base 08 - Red
color02="96/d2/a1" # Base 0B - Green
color03="f8/c9/70" # Base 0A - Yellow
color04="7c/bd/ff" # Base 0D - Blue
color05="b8/97/f0" # Base 0E - Magenta
color06="ac/da/e6" # Base 0C - Cyan
color07="d4/db/ea" # Base 05 - White
color08="2b/30/48" # Base 03 - Bright Black
color09="e6/90/88" # Base 12 - Bright Red
color10="af/ed/ba" # Base 14 - Bright Green
color11="ff/e4/b4" # Base 13 - Bright Yellow
color12="ae/d6/ff" # Base 16 - Bright Blue
color13="ff/be/e2" # Base 17 - Bright Magenta
color14="bf/f2/ff" # Base 15 - Bright Cyan
color15="d4/db/ea" # Base 07 - Bright White
color16="f2/b9/9f" # Base 09
color17="ed/9e/cb" # Base 0F
color18="18/1c/33" # Base 01
color19="21/26/3d" # Base 02
color20="63/6b/87" # Base 04
color21="ab/b0/c3" # Base 06
color_foreground="d4/db/ea" # Base 05
color_background="14/18/2c" # Base 00


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
  put_template_custom Pg d4dbea # foreground
  put_template_custom Ph 14182c # background
  put_template_custom Pi d4dbea # bold color
  put_template_custom Pj 21263d # selection color
  put_template_custom Pk d4dbea # selected text color
  put_template_custom Pl d4dbea # cursor
  put_template_custom Pm 14182c # cursor text
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
  export BASE24_COLOR_00_HEX="14182c"
  export BASE24_COLOR_01_HEX="181c33"
  export BASE24_COLOR_02_HEX="21263d"
  export BASE24_COLOR_03_HEX="2b3048"
  export BASE24_COLOR_04_HEX="636b87"
  export BASE24_COLOR_05_HEX="d4dbea"
  export BASE24_COLOR_06_HEX="abb0c3"
  export BASE24_COLOR_07_HEX="d4dbea"
  export BASE24_COLOR_08_HEX="da6d65"
  export BASE24_COLOR_09_HEX="f2b99f"
  export BASE24_COLOR_0A_HEX="f8c970"
  export BASE24_COLOR_0B_HEX="96d2a1"
  export BASE24_COLOR_0C_HEX="acdae6"
  export BASE24_COLOR_0D_HEX="7cbdff"
  export BASE24_COLOR_0E_HEX="b897f0"
  export BASE24_COLOR_0F_HEX="ed9ecb"
  export BASE24_COLOR_10_HEX="0a0d1e"
  export BASE24_COLOR_11_HEX="0e1124"
  export BASE24_COLOR_12_HEX="e69088"
  export BASE24_COLOR_13_HEX="ffe4b4"
  export BASE24_COLOR_14_HEX="afedba"
  export BASE24_COLOR_15_HEX="bff2ff"
  export BASE24_COLOR_16_HEX="aed6ff"
  export BASE24_COLOR_17_HEX="ffbee2"
fi
