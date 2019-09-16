{ pkgs, ... }:
let
  inherit (pkgs) adapta-backgrounds;
  inherit (builtins) readFile;
in
''
  ${readFile ./config}

  # set background
  output * bg ${adapta-backgrounds}/share/backgrounds/adapta/tri-fadeno.jpg fill
''
