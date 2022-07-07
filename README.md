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
git clone https://github.com/base16-project/base16-shell.git \
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

local base16_project_theme = os.getenv('BASE16_THEME')
if base16_project_theme and g.colors_name ~= 'base16-'..base16_project_theme then
  cmd('let base16colorspace=256')
  cmd('colorscheme base16-'..base16_project_theme)
end
```

### Base16-Tmux Users

This section is for [base16-tmux][3] users who have installed
[base16-tmux][3] through [TPM][10]. base16-shell will update (or create)
the `$HOME/.config/base16-project/tmux.base16.conf` file and set the
colorscheme. You need to source this file in your `.tmux.conf`. You can
do this by adding the following to your `.tmux.conf`:

```
source-file $HOME/.config/base16-project/tmux.base16.conf
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

## Usage

### Bash/ZSH

Theme aliases are prefixed with `base16_`. Type that in the command line
and press tab to perform tab-completion.

All relevant scripts have the extension `.sh`

### Fish

Theme aliases are prefixed with `base16-`. Type that in the command line
and press tab to perform tab-completion.

All relevant scripts have the extension `.fish`

### Base16-shell hooks

You can create your own base16-shell hooks. These scripts will execute
every time you use base16-shell to change your theme. When a theme is
changed via the command line alias prefixes, all executable scripts will
then be sourced. 

The hooks are used to switch the [base16-tmux][3] theme. If you want to
use your own `$BASE16_SHELL_HOOKS_PATH` directory, make sure to copy the
`$BASE16_SHELL_PATH/hooks` files across and set the
`$BASE16_SHELL_HOOKS_PATH` variable before sourcing base16-shell
profile_helper.

## Troubleshooting

Run the included **colortest** script and check that your colour
assignments appear correct. If your teminal does not support the setting
of colours in within the 256 colorspace (e.g. Apple Terminal), colours
17 to 21 will appear blue.

![setting 256 colourspace not supported][9]

If **colortest** is run without any arguments e.g. `./colortest` the hex
values shown will correspond to the default scheme. If you'd like to see
the hex values for a particular scheme pass the file name of the theme
as the arguement e.g. `./colortest base16-ocean.sh`.

### Inverted blacks and whites

This is the expected behaviour when using a light theme:
https://github.com/base16-project/base16-shell/issues/150

## Contributing

See [`CONTRIBUTING.md`][7], which contains building and contributing
instructions.

[1]: https://github.com/base16-project/base16
[2]: https://github.com/base16-project/base16-vim
[3]: https://github.com/mattdavis90/base16-tmux
[4]: https://github.com/base16-project/base16-builder-go
[5]: https://formulae.brew.sh
[6]: .github/workflows/update.yml
[7]: CONTRIBUTING.md
[8]: screenshots/base16-shell.png
[9]: screenshots/setting-256-colourspace-not-supported.png
[10]: https://github.com/tmux-plugins/tpm
