{ pkgs, usr, ... }:
{
  users.nrd.home.file = {
    ".background-image".source =
      "${pkgs.adapta-backgrounds}/share/backgrounds/adapta/tealized.jpg";

    ".xinitrc".text = "exec xmonad";

    "shots/dummy" = {
      onChange = ''
        rm $HOME/shots/dummy
      '';

      text = "";
    };

    ".xmonad/xmonad.hs".text = usr.xmonad."xmonad.hs";
  };
}
