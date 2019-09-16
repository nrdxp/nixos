{ pkgs, usr, ... }:
let
  inherit (usr.qutebrowser) config;
in
{
  "xdg/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-icon-theme-name=Papirus-Adapta
      gtk-theme-name=Adapta
      gtk-cursor-theme-name=Adwaita
    '';
    mode = "444";
  };

  "qutebrowser/config.py".text = config;
}
