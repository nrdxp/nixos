{ pkgs, ... }:
let
  inherit (pkgs) powerline-fonts dejavu_fonts;
in
{
  fonts =
    [ powerline-fonts dejavu_fonts ];

  fontconfig.defaultFonts = {
    monospace = [ "DejaVu Sans Mono for Powerline" ];
    sansSerif = [ "DejaVu Sans" ];
  };
}
