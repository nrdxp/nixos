{ pkgs, ... }:
with pkgs;
[ farbfeld         dmenu              haskellPackages.xmonad-contrib
  st               qutebrowser        haskellPackages.xmonad-extras
  adapta-gtk-theme papirus-icon-theme libsForQt5.qtstyleplugins
  xbanish          pinentry_gnome     networkmanager_dmenu
  libinput         dzen2              networkmanagerapplet
  maim             xclip              xmonad-with-packages
  xorg.xdpyinfo    feh                xss-lock
  librsvg          gnome-themes-extra gnome3.adwaita-icon-theme
  default-cursor   mpv                zathura
  ffmpeg_4         passdmenu          imgurbash2
]