#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Parchment Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="lumina-parchment-light"

color00="f3/e9/d2" # Base 00 - Black
color01="81/1d/1d" # Base 08 - Red
color02="1b/47/32" # Base 0B - Green
color03="90/5c/00" # Base 0A - Yellow
color04="2b/5a/94" # Base 0D - Blue
color05="59/4c/92" # Base 0E - Magenta
color06="00/64/76" # Base 0C - Cyan
color07="30/24/16" # Base 05 - White
color08="cd/c7/b9" # Base 03 - Bright Black
color09="5c/1d/1b" # Base 12 - Bright Red
color10="00/35/20" # Base 14 - Bright Green
color11="76/4a/00" # Base 13 - Bright Yellow
color12="17/46/7e" # Base 16 - Bright Blue
color13="64/29/55" # Base 17 - Bright Magenta
color14="00/4f/5e" # Base 15 - Bright Cyan
color15="30/24/16" # Base 07 - Bright White
color16="9c/52/24" # Base 09
color17="83/2f/6f" # Base 0F
color18="e9/e3/d5" # Base 01
color19="dd/d7/c9" # Base 02
color20="8c/7f/63" # Base 04
color21="52/46/2b" # Base 06
color_foreground="30/24/16" # Base 05
color_background="f3/e9/d2" # Base 00


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
  put_template_custom Pg 302416 # foreground
  put_template_custom Ph f3e9d2 # background
  put_template_custom Pi 302416 # bold color
  put_template_custom Pj ddd7c9 # selection color
  put_template_custom Pk 302416 # selected text color
  put_template_custom Pl 302416 # cursor
  put_template_custom Pm f3e9d2 # cursor text
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
  export BASE24_COLOR_00_HEX="f3e9d2"
  export BASE24_COLOR_01_HEX="e9e3d5"
  export BASE24_COLOR_02_HEX="ddd7c9"
  export BASE24_COLOR_03_HEX="cdc7b9"
  export BASE24_COLOR_04_HEX="8c7f63"
  export BASE24_COLOR_05_HEX="302416"
  export BASE24_COLOR_06_HEX="52462b"
  export BASE24_COLOR_07_HEX="302416"
  export BASE24_COLOR_08_HEX="811d1d"
  export BASE24_COLOR_09_HEX="9c5224"
  export BASE24_COLOR_0A_HEX="905c00"
  export BASE24_COLOR_0B_HEX="1b4732"
  export BASE24_COLOR_0C_HEX="006476"
  export BASE24_COLOR_0D_HEX="2b5a94"
  export BASE24_COLOR_0E_HEX="594c92"
  export BASE24_COLOR_0F_HEX="832f6f"
  export BASE24_COLOR_10_HEX="f7f2e6"
  export BASE24_COLOR_11_HEX="ece2cb"
  export BASE24_COLOR_12_HEX="5c1d1b"
  export BASE24_COLOR_13_HEX="764a00"
  export BASE24_COLOR_14_HEX="003520"
  export BASE24_COLOR_15_HEX="004f5e"
  export BASE24_COLOR_16_HEX="17467e"
  export BASE24_COLOR_17_HEX="642955"
fi
