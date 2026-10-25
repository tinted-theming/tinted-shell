#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Espresso Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-espresso-light"

color00="fb/ee/df" # Base 00 - Black
color01="cd/2e/3f" # Base 08 - Red
color02="1e/6d/37" # Base 0B - Green
color03="9d/5c/09" # Base 0A - Yellow
color04="03/67/9f" # Base 0D - Blue
color05="5c/4c/9a" # Base 0E - Magenta
color06="28/59/6c" # Base 0C - Cyan
color07="32/22/19" # Base 05 - White
color08="d6/cc/c0" # Base 03 - Bright Black
color09="97/40/43" # Base 12 - Bright Red
color10="06/58/26" # Base 14 - Bright Green
color11="83/4a/00" # Base 13 - Bright Yellow
color12="00/53/81" # Base 16 - Bright Blue
color13="6a/2c/65" # Base 17 - Bright Magenta
color14="00/46/5c" # Base 15 - Bright Cyan
color15="32/22/19" # Base 07 - Bright White
color16="6f/30/00" # Base 09
color17="80/3f/7b" # Base 0F
color18="f2/e8/dc" # Base 01
color19="e7/dc/d0" # Base 02
color20="92/82/70" # Base 04
color21="53/45/33" # Base 06
color_foreground="32/22/19" # Base 05
color_background="fb/ee/df" # Base 00


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
  put_template_custom Pg 322219 # foreground
  put_template_custom Ph fbeedf # background
  put_template_custom Pi 322219 # bold color
  put_template_custom Pj e7dcd0 # selection color
  put_template_custom Pk 322219 # selected text color
  put_template_custom Pl 322219 # cursor
  put_template_custom Pm fbeedf # cursor text
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
  export BASE24_COLOR_00_HEX="fbeedf"
  export BASE24_COLOR_01_HEX="f2e8dc"
  export BASE24_COLOR_02_HEX="e7dcd0"
  export BASE24_COLOR_03_HEX="d6ccc0"
  export BASE24_COLOR_04_HEX="928270"
  export BASE24_COLOR_05_HEX="322219"
  export BASE24_COLOR_06_HEX="534533"
  export BASE24_COLOR_07_HEX="322219"
  export BASE24_COLOR_08_HEX="cd2e3f"
  export BASE24_COLOR_09_HEX="6f3000"
  export BASE24_COLOR_0A_HEX="9d5c09"
  export BASE24_COLOR_0B_HEX="1e6d37"
  export BASE24_COLOR_0C_HEX="28596c"
  export BASE24_COLOR_0D_HEX="03679f"
  export BASE24_COLOR_0E_HEX="5c4c9a"
  export BASE24_COLOR_0F_HEX="803f7b"
  export BASE24_COLOR_10_HEX="fef7f0"
  export BASE24_COLOR_11_HEX="f4e7d8"
  export BASE24_COLOR_12_HEX="974043"
  export BASE24_COLOR_13_HEX="834a00"
  export BASE24_COLOR_14_HEX="065826"
  export BASE24_COLOR_15_HEX="00465c"
  export BASE24_COLOR_16_HEX="005381"
  export BASE24_COLOR_17_HEX="6a2c65"
fi
