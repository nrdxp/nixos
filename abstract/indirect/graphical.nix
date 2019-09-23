{ pkgs, usr, ... }:
let
  inherit (pkgs) nerdfonts;
in
{
  imports = [ ../../xtra/home.nix ./graphical ];
  fonts.fonts = [ nerdfonts ];

  programs.zsh.shellAliases = {
    feh = "feh --conversion-timeout 0";
  };
}
