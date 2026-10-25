#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Rayleigh Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-rayleigh-light"

color00="f7/fb/fe" # Base 00 - Black
color01="94/14/19" # Base 08 - Red
color02="18/75/38" # Base 0B - Green
color03="9b/64/00" # Base 0A - Yellow
color04="05/55/b7" # Base 0D - Blue
color05="69/3d/9c" # Base 0E - Magenta
color06="00/5c/71" # Base 0C - Cyan
color07="1d/26/38" # Base 05 - White
color08="d3/d9/dd" # Base 03 - Bright Black
color09="6b/1d/1b" # Base 12 - Bright Red
color10="00/5f/28" # Base 14 - Bright Green
color11="81/52/00" # Base 13 - Bright Yellow
color12="0a/44/90" # Base 16 - Bright Blue
color13="81/32/6b" # Base 17 - Bright Magenta
color14="00/47/58" # Base 15 - Bright Cyan
color15="1d/26/38" # Base 07 - Bright White
color16="a2/4e/0f" # Base 09
color17="a4/36/87" # Base 0F
color18="ef/f5/f9" # Base 01
color19="e3/e9/ed" # Base 02
color20="82/87/8b" # Base 04
color21="44/48/4c" # Base 06
color_foreground="1d/26/38" # Base 05
color_background="f7/fb/fe" # Base 00


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
  put_template_custom Pg 1d2638 # foreground
  put_template_custom Ph f7fbfe # background
  put_template_custom Pi 1d2638 # bold color
  put_template_custom Pj e3e9ed # selection color
  put_template_custom Pk 1d2638 # selected text color
  put_template_custom Pl 1d2638 # cursor
  put_template_custom Pm f7fbfe # cursor text
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
  export BASE24_COLOR_00_HEX="f7fbfe"
  export BASE24_COLOR_01_HEX="eff5f9"
  export BASE24_COLOR_02_HEX="e3e9ed"
  export BASE24_COLOR_03_HEX="d3d9dd"
  export BASE24_COLOR_04_HEX="82878b"
  export BASE24_COLOR_05_HEX="1d2638"
  export BASE24_COLOR_06_HEX="44484c"
  export BASE24_COLOR_07_HEX="1d2638"
  export BASE24_COLOR_08_HEX="941419"
  export BASE24_COLOR_09_HEX="a24e0f"
  export BASE24_COLOR_0A_HEX="9b6400"
  export BASE24_COLOR_0B_HEX="187538"
  export BASE24_COLOR_0C_HEX="005c71"
  export BASE24_COLOR_0D_HEX="0555b7"
  export BASE24_COLOR_0E_HEX="693d9c"
  export BASE24_COLOR_0F_HEX="a43687"
  export BASE24_COLOR_10_HEX="fdffff"
  export BASE24_COLOR_11_HEX="eff3f6"
  export BASE24_COLOR_12_HEX="6b1d1b"
  export BASE24_COLOR_13_HEX="815200"
  export BASE24_COLOR_14_HEX="005f28"
  export BASE24_COLOR_15_HEX="004758"
  export BASE24_COLOR_16_HEX="0a4490"
  export BASE24_COLOR_17_HEX="81326b"
fi
