#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

./install-dotfile .zprofile
./install-dotfile .zshrc.pre
./install-dotfile .zshrc.local

./install-dotfile .config/awesome/rc.lua
./install-dotfile .config/awesome/theme.lua
./install-dotfile .config/dircolours
./install-dotfile .config/dune/config
./install-dotfile .config/fabric.plugin.zsh
./install-dotfile .config/gdb/init
./install-dotfile .config/git/config
./install-dotfile .config/jshint.json
./install-dotfile .config/kitty/kitty.conf
./install-dotfile .config/lambda-term-inputrc
./install-dotfile .config/mpv/input.conf
./install-dotfile .config/nvim/init.vim
./install-dotfile .config/nvimpager/init.vim
./install-dotfile .config/ocaml/init.ml
./install-dotfile .config/pythonrc.py
./install-dotfile .config/qutebrowser/config.py
./install-dotfile .config/qutebrowser/override.css
./install-dotfile .config/tridactyl/tridactylrc
./install-dotfile .config/utop/init.ml
./install-dotfile .config/wgetrc
./install-dotfile .config/xinitrc
./install-dotfile .config/xkbcomp
./install-dotfile .config/Xresources

./install-dotfile .local/bin/chromedriver
./install-dotfile .local/bin/chromium
./install-dotfile .local/bin/evince
./install-dotfile .local/bin/feh
./install-dotfile .local/bin/file
./install-dotfile .local/bin/firefox
./install-dotfile .local/bin/garbage-collect-nix
./install-dotfile .local/bin/ip.sh
./install-dotfile .local/bin/mpa
./install-dotfile .local/bin/mpv
./install-dotfile .local/bin/neomutt
./install-dotfile .local/bin/nvimdiff
./install-dotfile .local/bin/qutebrowser
./install-dotfile .local/bin/qutebrowser-private
./install-dotfile .local/bin/setvolume.sh
./install-dotfile .local/bin/set-performance.sh
./install-dotfile .local/bin/update-dotfiles
./install-dotfile .local/bin/upgrade-nix
