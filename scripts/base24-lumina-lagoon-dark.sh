#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Lagoon Dark
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-lagoon-dark"

color00="18/2f/36" # Base 00 - Black
color01="df/73/70" # Base 08 - Red
color02="8d/ce/a3" # Base 0B - Green
color03="df/cc/78" # Base 0A - Yellow
color04="a0/c7/f9" # Base 0D - Blue
color05="c3/bb/fb" # Base 0E - Magenta
color06="84/d3/dc" # Base 0C - Cyan
color07="d4/e5/ea" # Base 05 - White
color08="2f/49/52" # Base 03 - Bright Black
color09="eb/96/92" # Base 12 - Bright Red
color10="a7/e8/bc" # Base 14 - Bright Green
color11="fb/e6/8b" # Base 13 - Bright Yellow
color12="c8/e0/ff" # Base 16 - Bright Blue
color13="ea/c1/ff" # Base 17 - Bright Magenta
color14="9d/ed/f7" # Base 15 - Bright Cyan
color15="d4/e5/ea" # Base 07 - Bright White
color16="fd/b0/7c" # Base 09
color17="da/9e/f6" # Base 0F
color18="1b/34/3c" # Base 01
color19="25/3f/47" # Base 02
color20="64/82/8b" # Base 04
color21="a2/b5/bb" # Base 06
color_foreground="d4/e5/ea" # Base 05
color_background="18/2f/36" # Base 00


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
  put_template_custom Pg d4e5ea # foreground
  put_template_custom Ph 182f36 # background
  put_template_custom Pi d4e5ea # bold color
  put_template_custom Pj 253f47 # selection color
  put_template_custom Pk d4e5ea # selected text color
  put_template_custom Pl d4e5ea # cursor
  put_template_custom Pm 182f36 # cursor text
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
  export BASE24_COLOR_00_HEX="182f36"
  export BASE24_COLOR_01_HEX="1b343c"
  export BASE24_COLOR_02_HEX="253f47"
  export BASE24_COLOR_03_HEX="2f4952"
  export BASE24_COLOR_04_HEX="64828b"
  export BASE24_COLOR_05_HEX="d4e5ea"
  export BASE24_COLOR_06_HEX="a2b5bb"
  export BASE24_COLOR_07_HEX="d4e5ea"
  export BASE24_COLOR_08_HEX="df7370"
  export BASE24_COLOR_09_HEX="fdb07c"
  export BASE24_COLOR_0A_HEX="dfcc78"
  export BASE24_COLOR_0B_HEX="8dcea3"
  export BASE24_COLOR_0C_HEX="84d3dc"
  export BASE24_COLOR_0D_HEX="a0c7f9"
  export BASE24_COLOR_0E_HEX="c3bbfb"
  export BASE24_COLOR_0F_HEX="da9ef6"
  export BASE24_COLOR_10_HEX="0e2228"
  export BASE24_COLOR_11_HEX="11282e"
  export BASE24_COLOR_12_HEX="eb9692"
  export BASE24_COLOR_13_HEX="fbe68b"
  export BASE24_COLOR_14_HEX="a7e8bc"
  export BASE24_COLOR_15_HEX="9dedf7"
  export BASE24_COLOR_16_HEX="c8e0ff"
  export BASE24_COLOR_17_HEX="eac1ff"
fi
