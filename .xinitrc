#eval $(gpg-agent --daemon) &
#eval 'gnome-keyring-daemon'  # SSH/GPG agent

nitrogen --restore &
#xmodmap .Xmodmap &
xkbcomp .xkbcomp.xkb $DISPLAY &

#xscreensaver -no-splash &
#xrandr --dpi 96 &
xrdb -merge .Xresources &
#u1sdtool --connect &
xset b off
#xcompmgr -c&
#devilspie -a &
#urxvd -f&
exec awesome 2> ~/.awesome-log
