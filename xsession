export PATH=$HOME/.cabal/bin:$PATH

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
dropbox start
SpiderOak &
if [[ `hostname` =~ nt51p9393 ]]; then
  synergys
else
  synergyc
fi

exec ck-launch-session i3
