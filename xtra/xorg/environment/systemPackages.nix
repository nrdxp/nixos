{ pkgs, ... }:
with pkgs;
[
  farbfeld
  haskellPackages.xmonad-contrib
  st
  haskellPackages.xmonad-extras
  xbanish
  libinput
  maim
  xclip
  xsel
  xmonad-with-packages
  xorg.xdpyinfo
  xss-lock
  imgurbash2
]
