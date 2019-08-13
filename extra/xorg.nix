# If included in configuration.nix this will enable my prefered configuration
# for the xorg server and xmonad along with some useful programs and services
args@{ pkgs, usr, ... }:
let recImport = import ../fn/recImport.nix args;
in
{ imports = [ ./home.nix ];
  fonts.fonts = [ pkgs.nerdfonts ];

  programs.slock.enable = true;

} // recImport ./xorg
