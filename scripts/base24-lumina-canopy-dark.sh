#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Canopy Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-canopy-dark"

color00="13/1d/16" # Base 00 - Black
color01="d3/66/5e" # Base 08 - Red
color02="96/d4/a2" # Base 0B - Green
color03="f2/bb/31" # Base 0A - Yellow
color04="8d/c6/ff" # Base 0D - Blue
color05="c1/b8/fc" # Base 0E - Magenta
color06="8c/e3/dd" # Base 0C - Cyan
color07="cd/db/d0" # Base 05 - White
color08="2a/36/2d" # Base 03 - Bright Black
color09="df/89/81" # Base 12 - Bright Red
color10="ae/ef/bb" # Base 14 - Bright Green
color11="ff/d9/89" # Base 13 - Bright Yellow
color12="be/de/ff" # Base 16 - Bright Blue
color13="f2/b9/f5" # Base 17 - Bright Magenta
color14="a1/fb/f5" # Base 15 - Bright Cyan
color15="cd/db/d0" # Base 07 - Bright White
color16="fd/ad/76" # Base 09
color17="d1/a5/d3" # Base 0F
color18="17/22/1a" # Base 01
color19="20/2c/24" # Base 02
color20="61/70/64" # Base 04
color21="ab/b4/ad" # Base 06
color_foreground="cd/db/d0" # Base 05
color_background="13/1d/16" # Base 00


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
  put_template_custom Pg cddbd0 # foreground
  put_template_custom Ph 131d16 # background
  put_template_custom Pi cddbd0 # bold color
  put_template_custom Pj 202c24 # selection color
  put_template_custom Pk cddbd0 # selected text color
  put_template_custom Pl cddbd0 # cursor
  put_template_custom Pm 131d16 # cursor text
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
  export BASE24_COLOR_00_HEX="131d16"
  export BASE24_COLOR_01_HEX="17221a"
  export BASE24_COLOR_02_HEX="202c24"
  export BASE24_COLOR_03_HEX="2a362d"
  export BASE24_COLOR_04_HEX="617064"
  export BASE24_COLOR_05_HEX="cddbd0"
  export BASE24_COLOR_06_HEX="abb4ad"
  export BASE24_COLOR_07_HEX="cddbd0"
  export BASE24_COLOR_08_HEX="d3665e"
  export BASE24_COLOR_09_HEX="fdad76"
  export BASE24_COLOR_0A_HEX="f2bb31"
  export BASE24_COLOR_0B_HEX="96d4a2"
  export BASE24_COLOR_0C_HEX="8ce3dd"
  export BASE24_COLOR_0D_HEX="8dc6ff"
  export BASE24_COLOR_0E_HEX="c1b8fc"
  export BASE24_COLOR_0F_HEX="d1a5d3"
  export BASE24_COLOR_10_HEX="09110b"
  export BASE24_COLOR_11_HEX="0c160f"
  export BASE24_COLOR_12_HEX="df8981"
  export BASE24_COLOR_13_HEX="ffd989"
  export BASE24_COLOR_14_HEX="aeefbb"
  export BASE24_COLOR_15_HEX="a1fbf5"
  export BASE24_COLOR_16_HEX="bedeff"
  export BASE24_COLOR_17_HEX="f2b9f5"
fi
