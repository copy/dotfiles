# copy's dotfiles

[Browse the repository online](//copy.sh/dotfiles/files.html) — [GitHub mirror](https://github.com/copy/dotfiles)

## Features

- `.config/awesome/rc.lua` is the config file for [awesome](https://awesomewm.org/), a lightweight, tiling window manager.
- neovim, nvimpager, nvimdiff
- The following programs are sandboxed using [bubblewrap](https://github.com/containers/bubblewrap/) (OCaml required):
    chromium, evince, feh, firefox, file, mpv, neomutt, qutebrowser
- zsh config using [grml's base config](https://grml.org/zsh/)
- Mostly uncluttered `$HOME`

## Usage

- `git clone https://copy.sh/dotfiles/dotfiles.git && cd dotfiles`
- Verify that `install.sh` isn't malicious, installs only the files you want and run it (it will print a diff for files that already exist)
- Or copy files from the repository manually
- (optionally) copy user.js to your Firefox profile directory manually
- (optionally) edit and run `.local/bin/system-install.sh` as root to install packages using `pacman` and do some system-wide configuration
