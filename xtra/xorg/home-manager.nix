{ pkgs, usr, dirs, ... }:
{
  users.nrd.home.file = {
    ".background-image".source =
      "${pkgs.adapta-backgrounds}/share/backgrounds/adapta/tealized.jpg";

    ".xinitrc".text = "exec xmonad";

    "${dirs.screenshots}/dummy" = {
      text = "";

      onChange = ''
        rm $HOME/${dirs.screenshots}/dummy
      '';
    };

    ".xmonad/xmonad.hs".text = usr.xmonad."xmonad.hs";
  };
}
