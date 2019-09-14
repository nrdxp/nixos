{ pkgs, ... }:
let
  inherit (pkgs) adapta-backgrounds;
in
(builtins.readFile ./config)
+ ''
  output * bg ${adapta-backgrounds}/share/backgrounds/adapta/tri-fadeno.jpg fill
''
