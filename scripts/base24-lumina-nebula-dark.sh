#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Nebula Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-nebula-dark"

color00="0a/11/1a" # Base 00 - Black
color01="d3/60/59" # Base 08 - Red
color02="8b/ce/99" # Base 0B - Green
color03="f7/cf/55" # Base 0A - Yellow
color04="92/be/f8" # Base 0D - Blue
color05="aa/aa/ec" # Base 0E - Magenta
color06="00/df/e5" # Base 0C - Cyan
color07="ca/dc/eb" # Base 05 - White
color08="20/28/33" # Base 03 - Bright Black
color09="df/84/7d" # Base 12 - Bright Red
color10="a3/e9/b2" # Base 14 - Bright Green
color11="ff/e6/a0" # Base 13 - Bright Yellow
color12="ba/d7/ff" # Base 16 - Bright Blue
color13="ff/bb/f7" # Base 17 - Bright Magenta
color14="8f/f1/f4" # Base 15 - Bright Cyan
color15="ca/dc/eb" # Base 07 - Bright White
color16="dd/c6/b0" # Base 09
color17="e3/a2/dc" # Base 0F
color18="0e/15/20" # Base 01
color19="17/1f/29" # Base 02
color20="60/6a/77" # Base 04
color21="ab/b2/bb" # Base 06
color_foreground="ca/dc/eb" # Base 05
color_background="0a/11/1a" # Base 00


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
  put_template_custom Pg cadceb # foreground
  put_template_custom Ph 0a111a # background
  put_template_custom Pi cadceb # bold color
  put_template_custom Pj 171f29 # selection color
  put_template_custom Pk cadceb # selected text color
  put_template_custom Pl cadceb # cursor
  put_template_custom Pm 0a111a # cursor text
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
  export BASE24_COLOR_00_HEX="0a111a"
  export BASE24_COLOR_01_HEX="0e1520"
  export BASE24_COLOR_02_HEX="171f29"
  export BASE24_COLOR_03_HEX="202833"
  export BASE24_COLOR_04_HEX="606a77"
  export BASE24_COLOR_05_HEX="cadceb"
  export BASE24_COLOR_06_HEX="abb2bb"
  export BASE24_COLOR_07_HEX="cadceb"
  export BASE24_COLOR_08_HEX="d36059"
  export BASE24_COLOR_09_HEX="ddc6b0"
  export BASE24_COLOR_0A_HEX="f7cf55"
  export BASE24_COLOR_0B_HEX="8bce99"
  export BASE24_COLOR_0C_HEX="00dfe5"
  export BASE24_COLOR_0D_HEX="92bef8"
  export BASE24_COLOR_0E_HEX="aaaaec"
  export BASE24_COLOR_0F_HEX="e3a2dc"
  export BASE24_COLOR_10_HEX="03070e"
  export BASE24_COLOR_11_HEX="050b13"
  export BASE24_COLOR_12_HEX="df847d"
  export BASE24_COLOR_13_HEX="ffe6a0"
  export BASE24_COLOR_14_HEX="a3e9b2"
  export BASE24_COLOR_15_HEX="8ff1f4"
  export BASE24_COLOR_16_HEX="bad7ff"
  export BASE24_COLOR_17_HEX="ffbbf7"
fi
