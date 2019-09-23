{ lib, pkgs, usr, ... }:
let
  inherit (lib.strings) removeSuffix;
  inherit (usr.qutebrowser) config;
in
self: super: {
  qutebrowser = super.qutebrowser.overrideAttrs (
    o: {
      postFixup = (removeSuffix "\n" super.qutebrowser.postFixup)
        + ''"-C /etc/xdg/qutebrowser/config.py" --add-flags ''
        ;
    }
  );
}
