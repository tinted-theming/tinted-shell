#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lavandula 
# Scheme author: FredHappyface (https://github.com/fredHappyface)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lavandula"

color00="05/00/14" # Base 00 - Black
color01="7c/15/25" # Base 08 - Red
color02="33/7e/6f" # Base 0B - Green
color03="8e/86/df" # Base 0A - Yellow
color04="4f/4a/7f" # Base 0D - Blue
color05="59/3f/7e" # Base 0E - Magenta
color06="57/76/7f" # Base 0C - Cyan
color07="73/6e/7d" # Base 06 - White
color08="37/2c/46" # Base 02 - Bright Black
color09="df/50/66" # Base 12 - Bright Red
color10="52/e0/c4" # Base 14 - Bright Green
color11="e0/c2/86" # Base 13 - Bright Yellow
color12="8e/86/df" # Base 16 - Bright Blue
color13="a6/75/df" # Base 17 - Bright Magenta
color14="9a/d3/df" # Base 15 - Bright Cyan
color15="8c/91/fa" # Base 07 - Bright White
color16="7f/6f/49" # Base 09
color17="3e/0a/12" # Base 0F
color18="23/00/45" # Base 01
color19="37/2c/46" # Base 02
color20="55/4d/61" # Base 04
color21="73/6e/7d" # Base 06
color_foreground="64/5d/6f" # Base 05
color_background="05/00/14" # Base 00


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
  put_template_custom Pg 645d6f # foreground
  put_template_custom Ph 050014 # background
  put_template_custom Pi 645d6f # bold color
  put_template_custom Pj 372c46 # selection color
  put_template_custom Pk 645d6f # selected text color
  put_template_custom Pl 645d6f # cursor
  put_template_custom Pm 050014 # cursor text
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
  export BASE24_COLOR_00_HEX="050014"
  export BASE24_COLOR_01_HEX="230045"
  export BASE24_COLOR_02_HEX="372c46"
  export BASE24_COLOR_03_HEX="463c53"
  export BASE24_COLOR_04_HEX="554d61"
  export BASE24_COLOR_05_HEX="645d6f"
  export BASE24_COLOR_06_HEX="736e7d"
  export BASE24_COLOR_07_HEX="8c91fa"
  export BASE24_COLOR_08_HEX="7c1525"
  export BASE24_COLOR_09_HEX="7f6f49"
  export BASE24_COLOR_0A_HEX="8e86df"
  export BASE24_COLOR_0B_HEX="337e6f"
  export BASE24_COLOR_0C_HEX="57767f"
  export BASE24_COLOR_0D_HEX="4f4a7f"
  export BASE24_COLOR_0E_HEX="593f7e"
  export BASE24_COLOR_0F_HEX="3e0a12"
  export BASE24_COLOR_10_HEX="241d2e"
  export BASE24_COLOR_11_HEX="120e17"
  export BASE24_COLOR_12_HEX="df5066"
  export BASE24_COLOR_13_HEX="e0c286"
  export BASE24_COLOR_14_HEX="52e0c4"
  export BASE24_COLOR_15_HEX="9ad3df"
  export BASE24_COLOR_16_HEX="8e86df"
  export BASE24_COLOR_17_HEX="a675df"
fi
