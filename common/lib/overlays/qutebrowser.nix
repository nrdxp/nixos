{ lib, ... }:
let
  inherit (lib.strings) removeSuffix;
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
