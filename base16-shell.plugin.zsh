script_path=${(%):-%x}
BASE16_SHELL=${script_path%/*}

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && source "$BASE16_SHELL/profile_helper.sh"
