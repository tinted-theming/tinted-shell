#!/usr/bin/env sh
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Violet Dark 
# Scheme author: FredHappyface (https://github.com/fredHappyface)
# Template author: Tinted Theming (https://github.com/tinted-theming)
export BASE24_THEME="violet-dark"

color00="1b/1d/1f" # Base 00 - Black
color01="c9/4c/22" # Base 08 - Red
color02="85/98/1c" # Base 0B - Green
color03="20/75/c7" # Base 0A - Yellow
color04="2e/8b/ce" # Base 0D - Blue
color05="d1/3a/82" # Base 0E - Magenta
color06="32/a1/98" # Base 0C - Cyan
color07="c8/c5/bc" # Base 06 - White
color08="45/48/4b" # Base 02 - Bright Black
color09="bd/36/12" # Base 12 - Bright Red
color10="72/89/03" # Base 14 - Bright Green
color11="a5/77/04" # Base 13 - Bright Yellow
color12="20/75/c7" # Base 16 - Bright Blue
color13="c6/1b/6e" # Base 17 - Bright Magenta
color14="25/91/85" # Base 15 - Bright Cyan
color15="c8/c5/bd" # Base 07 - Bright White
color16="b4/88/1d" # Base 09
color17="64/26/11" # Base 0F
color18="56/59/5c" # Base 01
color19="45/48/4b" # Base 02
color20="86/86/83" # Base 04
color21="c8/c5/bc" # Base 06
color_foreground="a7/a5/9f" # Base 05
color_background="1b/1d/1f" # Base 00


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
  put_template_custom Pg a7a59f # foreground
  put_template_custom Ph 1b1d1f # background
  put_template_custom Pi a7a59f # bold color
  put_template_custom Pj 45484b # selection color
  put_template_custom Pk a7a59f # selected text color
  put_template_custom Pl a7a59f # cursor
  put_template_custom Pm 1b1d1f # cursor text
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
  export BASE24_COLOR_00_HEX="1b1d1f"
  export BASE24_COLOR_01_HEX="56595c"
  export BASE24_COLOR_02_HEX="45484b"
  export BASE24_COLOR_03_HEX="656767"
  export BASE24_COLOR_04_HEX="868683"
  export BASE24_COLOR_05_HEX="a7a59f"
  export BASE24_COLOR_06_HEX="c8c5bc"
  export BASE24_COLOR_07_HEX="c8c5bd"
  export BASE24_COLOR_08_HEX="c94c22"
  export BASE24_COLOR_09_HEX="b4881d"
  export BASE24_COLOR_0A_HEX="2075c7"
  export BASE24_COLOR_0B_HEX="85981c"
  export BASE24_COLOR_0C_HEX="32a198"
  export BASE24_COLOR_0D_HEX="2e8bce"
  export BASE24_COLOR_0E_HEX="d13a82"
  export BASE24_COLOR_0F_HEX="642611"
  export BASE24_COLOR_10_HEX="2e3032"
  export BASE24_COLOR_11_HEX="171819"
  export BASE24_COLOR_12_HEX="bd3612"
  export BASE24_COLOR_13_HEX="a57704"
  export BASE24_COLOR_14_HEX="728903"
  export BASE24_COLOR_15_HEX="259185"
  export BASE24_COLOR_16_HEX="2075c7"
  export BASE24_COLOR_17_HEX="c61b6e"
fi
