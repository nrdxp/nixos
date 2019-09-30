{ pkgs, ... }:
let
  inherit (pkgs) adapta-backgrounds writeScript;
  inherit (builtins) readFile;
  volnoti = writeScript "volnoti.sh" (import ./volnoti.nix { inherit pkgs; });
in
''
  set $volume ${volnoti}

  # set background
  output * bg ${adapta-backgrounds}/share/backgrounds/adapta/tri-fadeno.jpg fill

  ${readFile ./config}
''
