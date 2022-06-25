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
  ~/.config/base16-shell
```

## Configuration

### Bash/ZSH

Add following lines to `~/.bashrc` or `~/.zshrc`:

```bash
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"
```

Open a new shell and type `base16` followed by a tab to perform tab
completion.

### Fish

Add following lines to `~/.config/fish/config.fish`:

```fish
# Base16 Shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end
```

Open a new shell and type `base16` followed by a tab to perform tab
completion.

### Base16-Vim Users

This section is for [base16-vim][2] users. base16-shell will update (or
create) the  `~/.vimrc_background` file and set the colorscheme. You
need to source this file in your `.vimrc`. You can do this by adding the
following to your `.vimrc`:

```shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
```
Remove the base16colorspace line if it is not needed.

### Base16-Tmux Users

This section is for [base16-tmux][3] users. base16-shell will update (or
create) the `~/.tmux.base16.conf` file and set the colorscheme. You need
to source this file in your `.tmux.conf`. You can do this by adding the
following to your `.tmux.conf`:

```
source-file ~/.tmux.base16.conf
```

Make sure to reload your `~/.tmux.conf` file after the theme has been
updated through `profile_helper`.

### Keeping your themes up to date

To update, just `git pull` wherever you've cloned `base16-shell`. The
themes are updated on a weekly basis thanks to GitHub Actions. See the
GitHub Actions workflow in [`.github/workflows/update.yml`][6].

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
