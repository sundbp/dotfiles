# my xdefaults
xrdb -merge ~/.Xdefaults

# no capslock
setxkbmap -option ctrl:nocaps

# cursor
xsetroot -cursor_name left_ptr

eval `cat ~/.fehbg`

exec ck-launch-session gnome-settings-daemon &
exec ck-launch-session /usr/lib/notification-daemon/notification-daemon &
eval `gnome-keyring-daemon`

nautilus --no-desktop --no-default-window

if [ -f /usr/bin/dropbox ]; then
  dropbox start
fi

if [ -f /usr/bin/synergy ]; then
  synergy &
fi

exec ck-launch-session i3
