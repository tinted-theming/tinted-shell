#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Parchment Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-parchment-dark"

color00="34/2d/21" # Base 00 - Black
color01="db/7d/75" # Base 08 - Red
color02="c3/dc/c7" # Base 0B - Green
color03="f3/cb/7f" # Base 0A - Yellow
color04="9e/bd/e6" # Base 0D - Blue
color05="b9/b3/e7" # Base 0E - Magenta
color06="89/c7/ce" # Base 0C - Cyan
color07="ee/e7/d9" # Base 05 - White
color08="4f/47/39" # Base 03 - Bright Black
color09="e8/9e/97" # Base 12 - Bright Red
color10="c4/f7/cd" # Base 14 - Bright Green
color11="ff/e4/b3" # Base 13 - Bright Yellow
color12="b8/d7/ff" # Base 16 - Bright Blue
color13="ec/b6/e0" # Base 17 - Bright Magenta
color14="a1/e1/e8" # Base 15 - Bright Cyan
color15="ee/e7/d9" # Base 07 - Bright White
color16="d8/a5/7e" # Base 09
color17="dd/95/ce" # Base 0F
color18="3a/32/24" # Base 01
color19="44/3c/2e" # Base 02
color20="87/7e/6d" # Base 04
color21="b6/b0/a6" # Base 06
color_foreground="ee/e7/d9" # Base 05
color_background="34/2d/21" # Base 00


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
  put_template_custom Pg eee7d9 # foreground
  put_template_custom Ph 342d21 # background
  put_template_custom Pi eee7d9 # bold color
  put_template_custom Pj 443c2e # selection color
  put_template_custom Pk eee7d9 # selected text color
  put_template_custom Pl eee7d9 # cursor
  put_template_custom Pm 342d21 # cursor text
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
  export BASE24_COLOR_00_HEX="342d21"
  export BASE24_COLOR_01_HEX="3a3224"
  export BASE24_COLOR_02_HEX="443c2e"
  export BASE24_COLOR_03_HEX="4f4739"
  export BASE24_COLOR_04_HEX="877e6d"
  export BASE24_COLOR_05_HEX="eee7d9"
  export BASE24_COLOR_06_HEX="b6b0a6"
  export BASE24_COLOR_07_HEX="eee7d9"
  export BASE24_COLOR_08_HEX="db7d75"
  export BASE24_COLOR_09_HEX="d8a57e"
  export BASE24_COLOR_0A_HEX="f3cb7f"
  export BASE24_COLOR_0B_HEX="c3dcc7"
  export BASE24_COLOR_0C_HEX="89c7ce"
  export BASE24_COLOR_0D_HEX="9ebde6"
  export BASE24_COLOR_0E_HEX="b9b3e7"
  export BASE24_COLOR_0F_HEX="dd95ce"
  export BASE24_COLOR_10_HEX="272117"
  export BASE24_COLOR_11_HEX="2e271b"
  export BASE24_COLOR_12_HEX="e89e97"
  export BASE24_COLOR_13_HEX="ffe4b3"
  export BASE24_COLOR_14_HEX="c4f7cd"
  export BASE24_COLOR_15_HEX="a1e1e8"
  export BASE24_COLOR_16_HEX="b8d7ff"
  export BASE24_COLOR_17_HEX="ecb6e0"
fi
