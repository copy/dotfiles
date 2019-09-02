#eval $(gpg-agent --daemon) &
#eval 'gnome-keyring-daemon'  # SSH/GPG agent

nitrogen --restore &
#xmodmap .Xmodmap &
xkbcomp .xkbcomp.xkb $DISPLAY &

#xscreensaver -no-splash &
xrandr --dpi 150 &
echo "runnning xrdb"
xrdb -merge .Xresources &
#u1sdtool --connect &
xset b off
#xcompmgr -c&
#devilspie -a &
#urxvd -f&

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export PATH=/home/fabian/.local/bin:$PATH
awesome 2> /tmp/awesome.log
