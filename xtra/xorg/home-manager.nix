{ pkgs, usr, ... }:
{
  users.nrd.home.file =
  { ".background-image".source     =
      "${pkgs.adapta-backgrounds}/share/backgrounds/adapta/tealized.jpg";

    ".local/share/qutebrowser/userscripts".source =
    ./lib/qutebrowser/scripts;

    ".xinitrc".text = "exec xmonad";

    ".config/qutebrowser/config.py" =
    {
      text = "config.source('/etc/qutebrowser/config.py')";

      # install spellchecker
      onChange =
      ''
      ${pkgs.qutebrowser}/share/qutebrowser/scripts/dictcli.py install en-US
      '';
    };

    "shots/dummy" =
    { onChange =
      ''
      rm $HOME/shots/dummy
      '';

      text = "";
    };

    ".xmonad/xmonad.hs".text = usr.xmonad."xmonad.hs";
  };
}
