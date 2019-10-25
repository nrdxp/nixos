{ pkgs, usr, ... }:
let
  inherit (pkgs) nerdfonts;
in
{
  imports = [ ../home.nix ./graphical ];
  fonts.fonts = [ nerdfonts ];

  programs.zsh.shellAliases = {
    feh = "feh --conversion-timeout 0";
  };
}
