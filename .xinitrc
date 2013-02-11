eval $(gpg-agent --daemon) &
eval 'gnome-keyring-daemon'  # SSH/GPG agent
nitrogen --restore &
xmodmap .Xmodmap &
xscreensaver -no-splash &
xrandr --dpi 96 &
xrdb -merge .Xresources &
awesome
