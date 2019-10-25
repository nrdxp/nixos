{ pkgs, usr, dirs, ... }:
let
  inherit (builtins) readFile;
  inherit (pkgs) writeScript dzvol;
  inherit (usr.xmonad) scripts;
  inherit (dirs) screenshots;
  autostart = writeScript "xmonad-autostart" scripts.autostart;

  stoggle = writeScript "xmonad-stoggle" scripts.stoggle;

  touchtoggle = writeScript "xmonad-touchtoggle" scripts.touchtoggle;
in
''
  ${readFile ./_xmonad.hs}
  ${import ./_xmonad.nix { inherit screenshots touchtoggle autostart dzvol stoggle; }}
''
