# copy's dotfiles

[Browse the repository online](//copy.sh/dotfiles/files.html) — [GitHub mirror](https://github.com/copy/dotfiles)

## Features

- `rc.lua` is the config file for [awesome](https://awesomewm.org/), a lightweight, tiling window manager.
- neovim, nvimpager, nvimdiff
- The following programs are wrapped using [bubblewrap](https://github.com/containers/bubblewrap/): chromium, evince, feh, firefox, file, mpv, neomutt, qutebrowser
    - Requires OCaml with [ExtUnix](https://github.com/ygrek/extunix) for some programs (the ExtUnix requirement will go away in OCaml 4.13)
- Mostly uncluttered `$HOME`

## Usage

- `git clone https://copy.sh/dotfiles/dotfiles.git && cd dotfiles`
- Verify that `install.sh` isn't malicious
- `./install.sh`
- (optionally) copy user.js to your Firefox profile directory manually
- (optionally) edit and run `.local/bin/system-install.sh` as root to install packages using `pacman` and do some system-wide configuration
