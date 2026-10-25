#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Oxblood Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-oxblood-dark"

color00="23/17/1b" # Base 00 - Black
color01="de/69/61" # Base 08 - Red
color02="7d/c7/97" # Base 0B - Green
color03="f9/c8/75" # Base 0A - Yellow
color04="96/c3/fb" # Base 0D - Blue
color05="be/b5/fc" # Base 0E - Magenta
color06="00/be/d0" # Base 0C - Cyan
color07="e4/d2/d7" # Base 05 - White
color08="3d/2f/33" # Base 03 - Bright Black
color09="e9/8e/86" # Base 12 - Bright Red
color10="98/e1/b1" # Base 14 - Bright Green
color11="ff/e4/b8" # Base 13 - Bright Yellow
color12="c0/dc/ff" # Base 16 - Bright Blue
color13="f2/d5/ff" # Base 17 - Bright Magenta
color14="76/d2/df" # Base 15 - Bright Cyan
color15="e4/d2/d7" # Base 07 - Bright White
color16="fc/a9/70" # Base 09
color17="dd/b7/ed" # Base 0F
color18="29/1b/20" # Base 01
color19="33/25/29" # Base 02
color20="79/68/6d" # Base 04
color21="b9/ad/b1" # Base 06
color_foreground="e4/d2/d7" # Base 05
color_background="23/17/1b" # Base 00


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
  put_template_custom Pg e4d2d7 # foreground
  put_template_custom Ph 23171b # background
  put_template_custom Pi e4d2d7 # bold color
  put_template_custom Pj 332529 # selection color
  put_template_custom Pk e4d2d7 # selected text color
  put_template_custom Pl e4d2d7 # cursor
  put_template_custom Pm 23171b # cursor text
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
  export BASE24_COLOR_00_HEX="23171b"
  export BASE24_COLOR_01_HEX="291b20"
  export BASE24_COLOR_02_HEX="332529"
  export BASE24_COLOR_03_HEX="3d2f33"
  export BASE24_COLOR_04_HEX="79686d"
  export BASE24_COLOR_05_HEX="e4d2d7"
  export BASE24_COLOR_06_HEX="b9adb1"
  export BASE24_COLOR_07_HEX="e4d2d7"
  export BASE24_COLOR_08_HEX="de6961"
  export BASE24_COLOR_09_HEX="fca970"
  export BASE24_COLOR_0A_HEX="f9c875"
  export BASE24_COLOR_0B_HEX="7dc797"
  export BASE24_COLOR_0C_HEX="00bed0"
  export BASE24_COLOR_0D_HEX="96c3fb"
  export BASE24_COLOR_0E_HEX="beb5fc"
  export BASE24_COLOR_0F_HEX="ddb7ed"
  export BASE24_COLOR_10_HEX="160c10"
  export BASE24_COLOR_11_HEX="1c1014"
  export BASE24_COLOR_12_HEX="e98e86"
  export BASE24_COLOR_13_HEX="ffe4b8"
  export BASE24_COLOR_14_HEX="98e1b1"
  export BASE24_COLOR_15_HEX="76d2df"
  export BASE24_COLOR_16_HEX="c0dcff"
  export BASE24_COLOR_17_HEX="f2d5ff"
fi
