# If included in configuration.nix this will enable my prefered configuration
# for the xorg server and xmonad along with some useful programs and services
{ pkgs, ... }:
{
  imports = [ ./home.nix ./xorg ];
  fonts.fonts = [ pkgs.nerdfonts ];
}
