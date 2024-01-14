# Base16 Shell

See the [Base16 repository][1] for more information.

A shell script to change your shell's default ANSI colors but most
importantly, colors 17 to 21 of your shell's 256 colorspace (if
supported by your terminal). This script makes it possible to honor the
original bright colors of your shell (e.g. bright green is still green
and so on) while providing additional base16 colors to applications such
as Vim and tmux.

![Base16 Shell][8]

## Use Cases

- You want to use a `*.256.*` variant of a Terminal theme designed to
  honor the original bright colors.
- You prefer to use a script instead of a terminal emulator theme to
  color your shell.
- You use this script to have different colorschemes appear on different
  SSH sessions.

## Installation

```shell
git clone https://github.com/tinted-theming/base16-shell.git \
  $HOME/.config/base16-shell
```

### Bash/ZSH

Add following lines to `.bashrc` or `.zshrc`:

```bash
# Base16 Shell
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"
```

### Oh my zsh

```bash
mkdir $HOME/.oh-my-zsh/plugins/base16-shell
ln -s $HOME/.config/base16-shell/base16-shell.plugin.zsh \
  $HOME/.oh-my-zsh/plugins/base16-shell/base16-shell.plugin.zsh
```

To use it, add `base16-shell` to the plugins array in your `.zshrc` file:

`plugins=(... base16-shell)`

### Fish

Add following lines to `$HOME/.config/fish/config.fish`:

```fish
# Base16 Shell
if status --is-interactive
  set BASE16_SHELL_PATH "$HOME/.config/base16-shell"
  if test -s "$BASE16_SHELL_PATH"
    source "$BASE16_SHELL_PATH/profile_helper.fish"
  end
end
```

### Tmux

Add the following to your `.tmux.conf` file.

```tmux
set -g allow-passthrough on # Enables ANSI pass through
```

## Configuration

### Base16-Vim Users

#### Vim

The `BASE16_THEME` environment variable will set to your current
colorscheme. You can set the [base16-vim][2] colorscheme to the
`BASE16_THEME` environment variable by adding the following to your
`.vimrc`:

```vim
if exists('$BASE16_THEME')
    \ && (!exists('g:colors_name') 
    \ || g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif
```

Remove the `base16colorspace` line if it is not needed.

#### Neovim

If you have a lua neovim config, add the following to your `init.lua`:

```lua
local cmd = vim.cmd
local g = vim.g

local current_theme_name = os.getenv('BASE16_THEME')
if current_theme_name and g.colors_name ~= 'base16-'..current_theme_name then
  cmd('let base16colorspace=256')
  cmd('colorscheme base16-'..current_theme_name)
end
```

#### Tmux & Vim

You should source the `set_theme` scripts to initialise your Vim
theme. This is necessary due to the way TMUX sessions handle environment
variables. Without this you may run into the issue where you've changed
your theme, but Vim loads with the theme you initialised TMUX with.

**Vim**

```vim
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
  let base16colorspace=256
  source $HOME/.config/tinted-theming/set_theme.vim
endif
```

**Neovim (Lua)**

```lua
local fn = vim.fn
local cmd = vim.cmd
local set_theme_path = "$HOME/.config/tinted-theming/set_theme.lua"
local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

if is_set_theme_file_readable then
  cmd("let base16colorspace=256")
  cmd("source " .. set_theme_path)
end
```

### Hooks

You can create your own base16-shell hooks. These scripts will execute
every time you use base16-shell to change your theme. When a theme is
changed via the command line alias prefixes, all executable scripts will
then be sourced. 

The hooks are used to switch the [base16-tmux][3] theme. If you want to
use your own `$BASE16_SHELL_HOOKS_PATH` directory, make sure to copy the
`$BASE16_SHELL_PATH/hooks` files across and set the
`$BASE16_SHELL_HOOKS_PATH` variable before sourcing base16-shell
profile_helper.

base16-shell follows the [XDG Base Directory Specification]. If you have
the `$XDG_CONFIG_HOME` variable set, it will look for the `base16-*`
cloned repos used for the shell hooks in
`$XDG_CONFIG_HOME/tinted-theming/base16-*`.

#### Tmux

You will automatically use this hook if you have installed
[base16-tmux][3] through [TPM][10]. base16-shell will update (or create)
the `$HOME/.config/tinted-theming/tmux.base16.conf` (or
`$XDG_CONFIG_HOME/tinted-theming/tmux.base16.conf`) file and set the
colorscheme. You need to source this file in your `.tmux.conf`. You can
do this by adding the following to your `.tmux.conf`:

```
source-file $HOME/.config/tinted-theming/tmux.base16.conf
```

If you're using XDG, make sure to have your tmux settings installed at
`$XDG_CONFIG_HOME/tmux`.

##### XDG

If you have XDG set up, make sure your tmux setup is installed at
`$XDG_CONFIG_HOME/tmux`

```
source-file $XDG_CONFIG_HOME/tinted-theming/tmux.base16.conf
```

#### FZF

Clone [base16-fzf][11] to `$HOME/.config/tinted-theming/base16-fzf` (or
`$XDG_CONFIG_HOME/tinted-theming/base16-fzf`). Once that is done the
hook will automatically pick that up and things will work as expected.

If you'd like to install to a different path, you can do that and set
`$BASE16_FZF_PATH` to your custom path.

#### HexChat (XChat)

1. Clone [base16-hexchat][12] to
   `$HOME/.config/tinted-theming/base16-hexchat` (or
   `$XDG_CONFIG_HOME/tinted-theming/base16-hexchat`). Or optionally
   install to a custom path and set `$BASE16_HEXCHAT_PATH` to that path.
2. Set the `$HEXCHAT_COLORS_CONF_PATH` shell variable to your hexchat
   `colors.conf` file. If you don't know where that is, read the
   [base16-hexchat][12] repo for more information. the hook will
   automatically pick that up and things will work as expected.

Note: Restart HexChat after you've changed the theme with base16-shell
to apply changes.

#### Delta

Add this line to your shell rc file:

```sh
export BASE16_SHELL_ENABLE_VARS=1
```

Include `delta.gitconfig` in your Git config file i.e. `~/.gitconfig`:

```gitconfig
[delta]
	syntax-theme = "ansi" # Use terminal colors
	# Rest of your delta config:
	navigate = true
	line-numbers = true
	# etc.

[include]
	# Import ${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/delta.gitconfig.
	# It will set delta.light=(true|false):
	path = ~/.config/tinted-theming/delta.gitconfig
```

> [!NOTE]
> You may need to restart your terminal/start a new shell for the changes to take effect.

#### Sublime Merge

[base16-sublime-merge] is required to be cloned or symlinked at
`path/to/sublimemerge/Packages/base16-sublime-merge`.

The Sublime Merge package path must be added to your shell `.*rc` file.
You find find this value by opening `Sublime Merge -> Preferences ->
Browse Packages...`. Add this directory path to your shell `.*rc` file:

```shell
export BASE16_SHELL_SUBLIMEMERGE_PACKAGE_PATH="path/to/sublime-merge/Packages"
```

### Keeping your themes up to date

To update, just `git pull` wherever you've cloned `base16-shell`. The
themes are updated on a weekly basis thanks to GitHub Actions. See the
GitHub Actions workflow in [`.github/workflows/update.yml`][6].

### Default theme

You can set the `$BASE16_THEME_DEFAULT` environment variable to the name
of a theme and it will use that theme if there is no theme currently
set. This can be useful for when you're using your dotfiles in a brand
new environment and you don't want to manually set the theme for the
first time.

For example: `$BASE16_THEME_DEFAULT="solarized-light"` 

### Default config path

You can customize where the generated configuration of this script is 
stored by setting the `$BASE16_CONFIG_PATH` environment variable before
the `profile_helper` script is loaded. This variable defaults to
`$HOME/.config/tinted-theming`.

If you are using oh-my-zsh you need to set this variable before 
`oh-my-zsh.sh` is sourced in your `.zshrc`.

## Usage

### Bash/ZSH

Theme aliases are prefixed with `base16_`. Type that in the command line
and press tab to perform tab-completion.

All relevant scripts have the extension `.sh`

### Fish

Theme aliases are prefixed with `base16-`. Type that in the command line
and press tab to perform tab-completion.

All relevant scripts have the extension `.fish`

### Customization using base16-shell

There are times when base16 templates don't exist for command line
applications, or perhaps you just want to play around with base16
colors. For those situations you can access active base16-shell theme
colors via `BASE16_COLOR_01_HEX` to `BASE16_COLOR_09_HEX` for colors 0-9
and `BASE16_COLOR_0A_HEX` to `BASE16_COLOR_0F_HEX` for colors 10-16.
Have a look at the [styling guidlines][13] for more information.

To enable this feature, make sure to export `BASE16_SHELL_ENABLE_VARS=1`
before base16-shell is loaded.

## Troubleshooting

Run the included **colortest** script and check that your colour
assignments appear correct. If your teminal does not support the setting
of colours in within the 256 colorspace (e.g. Apple Terminal), colours
17 to 21 will appear blue.

![setting 256 colourspace not supported][9]

If **colortest** is run without any arguments e.g. `./colortest` the hex
values shown will correspond to the currently set theme or the default
theme set with `BASE16_THEME_DEFAULT`. If you'd like to see the hex
values for a particular scheme pass the file name of the theme name as
the arguement e.g. `./colortest ocean`.

### Inverted blacks and whites

This is the expected behaviour when using a light theme:
https://github.com/tinted-theming/base16-shell/issues/150

## Contributing

See [`CONTRIBUTING.md`][7], which contains building and contributing
instructions.

[1]: https://github.com/tinted-theming/home
[2]: https://github.com/tinted-theming/base16-vim
[3]: https://github.com/mattdavis90/base16-tmux
[4]: https://github.com/tinted-theming/base16-builder-go
[5]: https://formulae.brew.sh
[6]: .github/workflows/update.yml
[7]: CONTRIBUTING.md
[8]: screenshots/base16-shell.png
[9]: screenshots/setting-256-colourspace-not-supported.png
[10]: https://github.com/tmux-plugins/tpm
[11]: https://github.com/tinted-theming/base16-fzf
[12]: https://github.com/tinted-theming/base16-hexchat
[13]: https://github.com/tinted-theming/home/blob/main/styling.md
[XDG Base Directory Specification]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[base16-sublime-merge]: https://github.com/tinted-theming/base16-sublime-merge
