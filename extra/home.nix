{ lib, config, pkgs, usr, ... }:
{
  imports =
  [ "${builtins.fetchGit https://github.com/rycee/home-manager}/nixos"
  ];

  home-manager.users.nrd =
  { home =
    {
      packages = lib.mkForce [];

      file = with usr;
      { ".zshrc".text                  = "";

        ".config/git/config".text    = usr.home.gitconfig;

        ".ssh/config".text           = home.ssh.config;
        ".ssh/github".text           = home.ssh.github;
        ".ssh/github.pub".text       = home.ssh."github.pub";
        ".ssh/gitlab".text           = home.ssh.gitlab;
        ".ssh/gitlab.pub".text       = home.ssh."gitlab.pub";

        ".gnupg/gpg-agent.conf".text = home.gnupg."gpg-agent.conf";
      } // lib.attrsets.optionalAttrs config.services.xserver.enable
      { ".background-image".source     =
          "${pkgs.adapta-backgrounds}/share/backgrounds/adapta/tealized.jpg";

        ".local/share/qutebrowser/userscripts".source =
        ../usr/qutebrowser/scripts;

        ".xinitrc" =
        { text = "exec xmonad";
        };

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
    };
  };

}
