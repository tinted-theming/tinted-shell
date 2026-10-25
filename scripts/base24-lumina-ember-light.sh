#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Ember Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-ember-light"

color00="fb/f8/f0" # Base 00 - Black
color01="97/25/24" # Base 08 - Red
color02="23/78/4f" # Base 0B - Green
color03="68/48/2d" # Base 0A - Yellow
color04="37/70/b0" # Base 0D - Blue
color05="66/45/99" # Base 0E - Magenta
color06="00/74/88" # Base 0C - Cyan
color07="3d/33/2b" # Base 05 - White
color08="d9/d5/ca" # Base 03 - Bright Black
color09="6f/26/23" # Base 12 - Bright Red
color10="00/63/3c" # Base 14 - Bright Green
color11="5c/31/00" # Base 13 - Bright Yellow
color12="23/5b/99" # Base 16 - Bright Blue
color13="7f/37/62" # Base 17 - Bright Magenta
color14="00/5e/6f" # Base 15 - Bright Cyan
color15="3d/33/2b" # Base 07 - Bright White
color16="ab/4b/00" # Base 09
color17="a4/3a/7c" # Base 0F
color18="f5/f1/e6" # Base 01
color19="ea/e6/db" # Base 02
color20="8a/86/7c" # Base 04
color21="4b/47/3e" # Base 06
color_foreground="3d/33/2b" # Base 05
color_background="fb/f8/f0" # Base 00


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
  put_template_custom Pg 3d332b # foreground
  put_template_custom Ph fbf8f0 # background
  put_template_custom Pi 3d332b # bold color
  put_template_custom Pj eae6db # selection color
  put_template_custom Pk 3d332b # selected text color
  put_template_custom Pl 3d332b # cursor
  put_template_custom Pm fbf8f0 # cursor text
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
  export BASE24_COLOR_00_HEX="fbf8f0"
  export BASE24_COLOR_01_HEX="f5f1e6"
  export BASE24_COLOR_02_HEX="eae6db"
  export BASE24_COLOR_03_HEX="d9d5ca"
  export BASE24_COLOR_04_HEX="8a867c"
  export BASE24_COLOR_05_HEX="3d332b"
  export BASE24_COLOR_06_HEX="4b473e"
  export BASE24_COLOR_07_HEX="3d332b"
  export BASE24_COLOR_08_HEX="972524"
  export BASE24_COLOR_09_HEX="ab4b00"
  export BASE24_COLOR_0A_HEX="68482d"
  export BASE24_COLOR_0B_HEX="23784f"
  export BASE24_COLOR_0C_HEX="007488"
  export BASE24_COLOR_0D_HEX="3770b0"
  export BASE24_COLOR_0E_HEX="664599"
  export BASE24_COLOR_0F_HEX="a43a7c"
  export BASE24_COLOR_10_HEX="fffffb"
  export BASE24_COLOR_11_HEX="f3f0e8"
  export BASE24_COLOR_12_HEX="6f2623"
  export BASE24_COLOR_13_HEX="5c3100"
  export BASE24_COLOR_14_HEX="00633c"
  export BASE24_COLOR_15_HEX="005e6f"
  export BASE24_COLOR_16_HEX="235b99"
  export BASE24_COLOR_17_HEX="7f3762"
fi
