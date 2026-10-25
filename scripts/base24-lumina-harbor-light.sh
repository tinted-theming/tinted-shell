#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Harbor Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-harbor-light"

color00="e6/f2/fe" # Base 00 - Black
color01="99/2a/28" # Base 08 - Red
color02="00/77/42" # Base 0B - Green
color03="a5/58/00" # Base 0A - Yellow
color04="28/63/ab" # Base 0D - Blue
color05="7f/5b/b6" # Base 0E - Magenta
color06="00/6f/82" # Base 0C - Cyan
color07="1b/27/37" # Base 05 - White
color08="c4/cf/db" # Base 03 - Bright Black
color09="71/2a/26" # Base 12 - Bright Red
color10="08/60/35" # Base 14 - Bright Green
color11="88/48/06" # Base 13 - Bright Yellow
color12="1e/50/8b" # Base 16 - Bright Blue
color13="70/36/6c" # Base 17 - Bright Magenta
color14="00/59/69" # Base 15 - Bright Cyan
color15="1b/27/37" # Base 07 - Bright White
color16="a5/58/00" # Base 09
color17="87/48/82" # Base 0F
color18="e0/eb/f7" # Base 01
color19="d4/e0/eb" # Base 02
color20="78/86/95" # Base 04
color21="3c/49/57" # Base 06
color_foreground="1b/27/37" # Base 05
color_background="e6/f2/fe" # Base 00


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
  put_template_custom Pg 1b2737 # foreground
  put_template_custom Ph e6f2fe # background
  put_template_custom Pi 1b2737 # bold color
  put_template_custom Pj d4e0eb # selection color
  put_template_custom Pk 1b2737 # selected text color
  put_template_custom Pl 1b2737 # cursor
  put_template_custom Pm e6f2fe # cursor text
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
  export BASE24_COLOR_00_HEX="e6f2fe"
  export BASE24_COLOR_01_HEX="e0ebf7"
  export BASE24_COLOR_02_HEX="d4e0eb"
  export BASE24_COLOR_03_HEX="c4cfdb"
  export BASE24_COLOR_04_HEX="788695"
  export BASE24_COLOR_05_HEX="1b2737"
  export BASE24_COLOR_06_HEX="3c4957"
  export BASE24_COLOR_07_HEX="1b2737"
  export BASE24_COLOR_08_HEX="992a28"
  export BASE24_COLOR_09_HEX="a55800"
  export BASE24_COLOR_0A_HEX="a55800"
  export BASE24_COLOR_0B_HEX="007742"
  export BASE24_COLOR_0C_HEX="006f82"
  export BASE24_COLOR_0D_HEX="2863ab"
  export BASE24_COLOR_0E_HEX="7f5bb6"
  export BASE24_COLOR_0F_HEX="874882"
  export BASE24_COLOR_10_HEX="f3f9ff"
  export BASE24_COLOR_11_HEX="dfebf7"
  export BASE24_COLOR_12_HEX="712a26"
  export BASE24_COLOR_13_HEX="884806"
  export BASE24_COLOR_14_HEX="086035"
  export BASE24_COLOR_15_HEX="005969"
  export BASE24_COLOR_16_HEX="1e508b"
  export BASE24_COLOR_17_HEX="70366c"
fi
