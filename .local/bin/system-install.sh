# To be run manually

packages=(
    awesome xorg-server vicious
    #nvidia libva-vdpau-driver
    netctl
    xorg-xinit xorg-xinput xorg-xrandr xorg-xdpyinfo xorg-xev xdotool
    #systemd-boot
    #intel-ucode
    #libva-intel-driver libva-utils
    firefox chromium
    firefox-tridactyl firefox-ublock-origin firefox-extension-https-everywhere firefox-decentraleyes firefox-dark-reader
    kitty xterm
    wpa_supplicant dialog
    pavucontrol
    pulseaudio pulseaudio-alsa
    dnscrypt-proxy
    dhcpcd
    openssh
    zsh
    grml-zsh-config zsh-completions zsh-syntax-highlighting
    ttf-liberation
    man-db man-pages
    pkgfile
    file
    alsa-utils
    wavemon
    qemu
    bubblewrap
    neovim
    python-neovim
    net-tools bind-tools gnu-netcat traceroute
    youtube-dl rtmpdump
    ocaml ocaml-findlib
    opam
    zeromq
    #texlive-bin texlive-core texlive-latexextra texlive-pictures
    ripgrep rustup
    gdb lldb perf
    xdg-user-dirs
    hddtemp
    redshift
    git svn mercurial
    fakeroot
    ncdu
    z3
    wget curl
    strace lsof
    sqlitebrowser
    mpv shotwell firefox-developer-edition
    unzip zip zstd unrar p7zip zopfli brotli
    rsync
    qutebrowser pdfjs pdfgrep
    afl
    wireguard-tools openvpn
    iftop iotop nethogs cmake make patch m4
    wine winetricks
    obs-studio ffmpeg
    bash-completion fzf
    kmymoney aqbanking
    vinagre freerdp
    go
    nasm
    rclone
    xlockmore
    borg borgmatic python-llfuse
    cmus
    scrot
    feh
    gimp
    gsmartcontrol
    htop sysstat
    youtube-dl
    glib2
    lib32-libvdpau
    pkg-config
    neomutt offlineimap spamassassin elinks
    ipython
    docker
    perl-image-exiftool
    kakoune kak-lsp
    evince mupdf
    python2-pip
    cronie
    entr nginx
    cpupower
    speedtest-cli
    jre11-openjdk-headless # closure compiler
    goaccess geoip2-database
    automake # to build nix
    squashfs-tools
    imagemagick
    streamlink
    lib32-curl lib32-gtk3 # red
    #flashplugin pepper-flash
    acpi
    pacman-contrib
    cloc tree
    jhead
    xournalpp
    noto-fonts noto-fonts-emoji noto-fonts-cjk # emoji and other unicode crap in terminal and firefox
    mypy python-pyflakes
    vint
    android-tools
    iw
    macchanger
    rmlint
    dmidecode
    virt-viewer
    usbutils
    hdparm
    encfs fscrypt
    wabt binaryen
    cdrtools # mkisofs
    packer
    cpio
    bc
    ntp # ntpd -q to update time once
    screen
    asar
    blueman pulseaudio-bluetooth
    zig patchelf
)

pacman -S "${packages[@]}"

pacman -U /tmp/yay-9.4.2-1-x86_64.pkg.tar
yay -S devd zoom tzupdate pandoc-bin python-dictcc
yay -S fswatch # dune watch mode
yay -S nix
yay -S chatterino2-git
yay -S nodejs-jsonlint htmlhint
yay -S graphviz # dot
yay -S create_ap

systemctl enable cronie.service # save-zsh script
xdg-settings set default-web-browser firefox.desktop

pip3 install fabric3
#pip2 install pynvim # merlin: should not be needed anymore

sa-update # spamassassin

echo "kernel.sysrq = 1" > /etc/sysctl.d/99-sysctl.conf
echo "/opt/x86_64-linux-musl-native/lib" > /etc/ld-musl-x86_64.path

systemctl mask systemd-binfmt.service # enabled by wine to execute windows executables

# /etc/sysctl.d/*
