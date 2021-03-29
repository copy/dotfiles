[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority exec startx ./.config/xinitrc
