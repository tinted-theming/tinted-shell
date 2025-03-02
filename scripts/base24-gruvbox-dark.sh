#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Gruvbox Dark 
# Scheme author: FredHappyface (https://github.com/fredHappyface)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="gruvbox-dark"

color00="1d/1d/1d" # Base 00 - Black
color01="be/0e/17" # Base 08 - Red
color02="86/87/15" # Base 0B - Green
color03="70/95/85" # Base 0A - Yellow
color04="37/72/74" # Base 0D - Blue
color05="9f/4b/73" # Base 0E - Magenta
color06="56/8d/57" # Base 0C - Cyan
color07="97/87/71" # Base 06 - White
color08="7f/70/60" # Base 02 - Bright Black
color09="f6/30/28" # Base 12 - Bright Red
color10="a9/b0/1d" # Base 14 - Bright Green
color11="f7/b0/24" # Base 13 - Bright Yellow
color12="70/95/85" # Base 16 - Bright Blue
color13="c7/6f/89" # Base 17 - Bright Magenta
color14="7d/b5/68" # Base 15 - Bright Cyan
color15="e5/d3/a2" # Base 07 - Bright White
color16="cc/87/1a" # Base 09
color17="5f/07/0b" # Base 0F
color18="1d/1d/1d" # Base 01
color19="7f/70/60" # Base 02
color20="8b/7b/68" # Base 04
color21="97/87/71" # Base 06
color_foreground="91/81/6c" # Base 05
color_background="1d/1d/1d" # Base 00


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
  put_template_custom Pg 91816c # foreground
  put_template_custom Ph 1d1d1d # background
  put_template_custom Pi 91816c # bold color
  put_template_custom Pj 7f7060 # selection color
  put_template_custom Pk 91816c # selected text color
  put_template_custom Pl 91816c # cursor
  put_template_custom Pm 1d1d1d # cursor text
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
  export BASE24_COLOR_00_HEX="1d1d1d"
  export BASE24_COLOR_01_HEX="1d1d1d"
  export BASE24_COLOR_02_HEX="7f7060"
  export BASE24_COLOR_03_HEX="857564"
  export BASE24_COLOR_04_HEX="8b7b68"
  export BASE24_COLOR_05_HEX="91816c"
  export BASE24_COLOR_06_HEX="978771"
  export BASE24_COLOR_07_HEX="e5d3a2"
  export BASE24_COLOR_08_HEX="be0e17"
  export BASE24_COLOR_09_HEX="cc871a"
  export BASE24_COLOR_0A_HEX="709585"
  export BASE24_COLOR_0B_HEX="868715"
  export BASE24_COLOR_0C_HEX="568d57"
  export BASE24_COLOR_0D_HEX="377274"
  export BASE24_COLOR_0E_HEX="9f4b73"
  export BASE24_COLOR_0F_HEX="5f070b"
  export BASE24_COLOR_10_HEX="544a40"
  export BASE24_COLOR_11_HEX="2a2520"
  export BASE24_COLOR_12_HEX="f63028"
  export BASE24_COLOR_13_HEX="f7b024"
  export BASE24_COLOR_14_HEX="a9b01d"
  export BASE24_COLOR_15_HEX="7db568"
  export BASE24_COLOR_16_HEX="709585"
  export BASE24_COLOR_17_HEX="c76f89"
fi
