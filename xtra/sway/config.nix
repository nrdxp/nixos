{ pkgs, ... }:
let
  inherit (pkgs) adapta-backgrounds;
  inherit (builtins) readFile;
in
''
  # set background
  output * bg ${adapta-backgrounds}/share/backgrounds/adapta/tri-fadeno.jpg fill

  ${readFile ./config}
''
