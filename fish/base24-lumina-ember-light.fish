#!/usr/bin/env fish
# tinted-shell (https://github.com/tinted-theming/tinted-shell)
# Scheme name: Lumina Ember Light
# Scheme author: Razik Ikhlef (https://github.com/RazikSF)
# Template author: Tinted Theming (https://github.com/tinted-theming)

set -l color00 "fb/f8/f0" # Base 00 - Black
set -l color01 "97/25/24" # Base 08 - Red
set -l color02 "23/78/4f" # Base 0B - Green
set -l color03 "68/48/2d" # Base 0A - Yellow
set -l color04 "37/70/b0" # Base 0D - Blue
set -l color05 "66/45/99" # Base 0E - Magenta
set -l color06 "00/74/88" # Base 0C - Cyan
set -l color07 "3d/33/2b" # Base 05 - White
set -l color08 "d9/d5/ca" # Base 03 - Bright Black
set -l color09 "6f/26/23" # Base 12 - Bright Red
set -l color10 "00/63/3c" # Base 14 - Bright Green
set -l color11 "5c/31/00" # Base 13 - Bright Yellow
set -l color12 "23/5b/99" # Base 16 - Bright Blue
set -l color13 "7f/37/62" # Base 17 - Bright Magenta
set -l color14 "00/5e/6f" # Base 15 - Bright Cyan
set -l color15 "3d/33/2b" # Base 07 - Bright White
set -l color16 "ab/4b/00" # Base 09
set -l color17 "a4/3a/7c" # Base 0F
set -l color18 "f5/f1/e6" # Base 01
set -l color19 "ea/e6/db" # Base 02
set -l color20 "8a/86/7c" # Base 04
set -l color21 "4b/47/3e" # Base 06
set -l color_foreground "3d/33/2b" # Base 05
set -l color_background "fb/f8/f0" # Base 00

if test -z "$TTY"
  set -gx TTY (tty)
end
if test -z "$TTY"; or not test -w "$TTY"
  function put_template; true; end
  function put_template_var; true; end
  function put_template_custom; true; end
else if set -q TMUX; or string match -q 'tmux*' $TERM
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  function put_template; printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $argv > "$TTY"; end
  function put_template_var; printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $argv > "$TTY"; end
  function put_template_custom; printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $argv > "$TTY"; end
else if string match -q 'screen*' $TERM
  # GNU screen (screen, screen-256color, screen-256color-bce)
  function put_template; printf '\033P\033]4;%d;rgb:%s\007\033\\' $argv > "$TTY"; end
  function put_template_var; printf '\033P\033]%d;rgb:%s\007\033\\' $argv > "$TTY"; end
  function put_template_custom; printf '\033P\033]%s%s\007\033\\' $argv > "$TTY"; end
else if string match -q 'linux*' $TERM
  function put_template; test $argv[1] -lt 16 && printf "\e]P%x%s" $argv[1] (echo $argv[2] | sed 's/\///g') > "$TTY"; end
  function put_template_var; true; end
  function put_template_custom; true; end
else
  function put_template; printf '\033]4;%d;rgb:%s\033\\' $argv > "$TTY"; end
  function put_template_var; printf '\033]%d;rgb:%s\033\\' $argv > "$TTY"; end
  function put_template_custom; printf '\033]%s%s\033\\' $argv > "$TTY"; end
end

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if test -n "$ITERM_SESSION_ID"
  put_template_custom Pg 3d332b # foreground
  put_template_custom Ph fbf8f0 # background
  put_template_custom Pi 3d332b # bold color
  put_template_custom Pj eae6db # selection color
  put_template_custom Pk 3d332b # selected text color
  put_template_custom Pl 3d332b # cursor
  put_template_custom Pm fbf8f0 # cursor text
else
  put_template_var 10 $color_foreground
  if test "$BASE24_SHELL_SET_BACKGROUND" != false
    put_template_var 11 $color_background
    if string match -q 'rxvt*' $TERM
      put_template_var 708 $color_background # internal border (rxvt)
    end
  end
  put_template_custom 12 ";7" # cursor (reverse video)
end

set -U fish_color_normal normal
set -U fish_color_command blue
set -U fish_color_keyword magenta
set -U fish_color_quote green
set -U fish_color_redirection brblue
set -U fish_color_end normal
set -U fish_color_error brred
set -U fish_color_param brcyan
set -U fish_color_valid_path --underline
set -U fish_color_option brcyan --italics
set -U fish_color_comment d9d5ca
set -U fish_color_selection 4b473e --background=eae6db
set -U fish_color_operator magenta
set -U fish_color_escape ab4b00
set -U fish_color_autosuggestion d9d5ca
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_host_remote normal
set -U fish_color_status red
set -U fish_color_cancel -r
set -U fish_color_search_match yellow --background=eae6db
set -U fish_color_history_current --underline=curly
set -U fish_pager_color_progress f5f1e6 --background=8a867c
set -U fish_pager_color_background --background=fbf8f0
set -U fish_pager_color_prefix --bold --italics
set -U fish_pager_color_completion normal
set -U fish_pager_color_description ab4b00
set -U fish_pager_color_selected_background --background=eae6db
set -U fish_pager_color_selected_prefix --bold --italics --background=eae6db
set -U fish_pager_color_selected_completion normal
set -U fish_pager_color_description ab4b00

# clean up
set -e color00
set -e color01
set -e color02
set -e color03
set -e color04
set -e color05
set -e color06
set -e color07
set -e color08
set -e color09
set -e color10
set -e color11
set -e color12
set -e color13
set -e color14
set -e color15
set -e color16
set -e color17
set -e color18
set -e color19
set -e color20
set -e color21
set -e color_foreground
set -e color_background
functions -e put_template put_template_var put_template_custom
set -l legacy_env (string match -r '^(BASE16|BASE24|TINTED8)_(THEME|COLOR_).*' (set -xn))
test -n "$legacy_env"; and set -e $legacy_env
set -l legacy_env (string match -r '^(BASE16|BASE24|TINTED8)_THEME' (set -Uxn))
test -n "$legacy_env"; and set -Ue $legacy_env
set -e legacy_env

# Set theme
set -Ux BASE24_THEME lumina-ember-light

# Optionally export variables
if test -n "$TINTED_SHELL_ENABLE_BASE24_VARS"; or test -n "$BASE24_SHELL_ENABLE_VARS"
  set -gx BASE24_COLOR_00_HEX "fbf8f0"
  set -gx BASE24_COLOR_01_HEX "f5f1e6"
  set -gx BASE24_COLOR_02_HEX "eae6db"
  set -gx BASE24_COLOR_03_HEX "d9d5ca"
  set -gx BASE24_COLOR_04_HEX "8a867c"
  set -gx BASE24_COLOR_05_HEX "3d332b"
  set -gx BASE24_COLOR_06_HEX "4b473e"
  set -gx BASE24_COLOR_07_HEX "3d332b"
  set -gx BASE24_COLOR_08_HEX "972524"
  set -gx BASE24_COLOR_09_HEX "ab4b00"
  set -gx BASE24_COLOR_0A_HEX "68482d"
  set -gx BASE24_COLOR_0B_HEX "23784f"
  set -gx BASE24_COLOR_0C_HEX "007488"
  set -gx BASE24_COLOR_0D_HEX "3770b0"
  set -gx BASE24_COLOR_0E_HEX "664599"
  set -gx BASE24_COLOR_0F_HEX "a43a7c"
end
