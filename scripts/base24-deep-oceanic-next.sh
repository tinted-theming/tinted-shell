#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Deep Oceanic Next 
# Scheme author: spearkkk (https://github.com/spearkkk/deep-oceanic-next)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="deep-oceanic-next"

color00="00/3b/46" # Base 00 - Black
color01="e6/45/4b" # Base 08 - Red
color02="85/b5/7a" # Base 0B - Green
color03="ff/cc/66" # Base 0A - Yellow
color04="3a/82/e6" # Base 0D - Blue
color05="8c/4d/e6" # Base 0E - Magenta
color06="4d/a6/a6" # Base 0C - Cyan
color07="e6/eb/f0" # Base 06 - White
color08="00/63/74" # Base 02 - Bright Black
color09="ff/5a/61" # Base 12 - Bright Red
color10="99/d8/a0" # Base 14 - Bright Green
color11="ff/dd/80" # Base 13 - Bright Yellow
color12="4d/a6/ff" # Base 16 - Bright Blue
color13="a3/66/ff" # Base 17 - Bright Magenta
color14="66/cc/cc" # Base 15 - Bright Cyan
color15="f0/f5/f5" # Base 07 - Bright White
color16="ff/6a/4b" # Base 09
color17="e6/73/a3" # Base 0F
color18="00/4f/5e" # Base 01
color19="00/63/74" # Base 02
color20="00/93/a3" # Base 04
color21="e6/eb/f0" # Base 06
color_foreground="dc/e3/e8" # Base 05
color_background="00/3b/46" # Base 00

if [ -n "$TMUX" ] || [ "${TERM%%[-.]*}" = "tmux" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' "$@"; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' "$@"; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' "$@"; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' "$@"; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' "$@"; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' "$@"; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ "$1" -lt 16 ] && printf "\e]P%x%s" "$1" "$(echo "$2" | sed 's/\///g')"; }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' "$@"; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' "$@"; }
  put_template_custom() { printf '\033]%s%s\033\\' "$@"; }
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
  put_template_custom Pg dce3e8 # foreground
  put_template_custom Ph 003b46 # background
  put_template_custom Pi dce3e8 # bold color
  put_template_custom Pj 006374 # selection color
  put_template_custom Pk dce3e8 # selected text color
  put_template_custom Pl dce3e8 # cursor
  put_template_custom Pm 003b46 # cursor text
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
  export BASE24_COLOR_00_HEX="003b46"
  export BASE24_COLOR_01_HEX="004f5e"
  export BASE24_COLOR_02_HEX="006374"
  export BASE24_COLOR_03_HEX="007a8a"
  export BASE24_COLOR_04_HEX="0093a3"
  export BASE24_COLOR_05_HEX="dce3e8"
  export BASE24_COLOR_06_HEX="e6ebf0"
  export BASE24_COLOR_07_HEX="f0f5f5"
  export BASE24_COLOR_08_HEX="e6454b"
  export BASE24_COLOR_09_HEX="ff6a4b"
  export BASE24_COLOR_0A_HEX="ffcc66"
  export BASE24_COLOR_0B_HEX="85b57a"
  export BASE24_COLOR_0C_HEX="4da6a6"
  export BASE24_COLOR_0D_HEX="3a82e6"
  export BASE24_COLOR_0E_HEX="8c4de6"
  export BASE24_COLOR_0F_HEX="e673a3"
  export BASE24_COLOR_10_HEX="001114"
  export BASE24_COLOR_11_HEX="000a0d"
  export BASE24_COLOR_12_HEX="ff5a61"
  export BASE24_COLOR_13_HEX="ffdd80"
  export BASE24_COLOR_14_HEX="99d8a0"
  export BASE24_COLOR_15_HEX="66cccc"
  export BASE24_COLOR_16_HEX="4da6ff"
  export BASE24_COLOR_17_HEX="a366ff"
fi
