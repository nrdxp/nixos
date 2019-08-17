{ lib, usr, ... }:
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

        ".config/git/config".text    = home.gitconfig;

        ".ssh/config".text           = home.ssh.config;
        ".ssh/github".text           = home.ssh.github;
        ".ssh/github.pub".text       = home.ssh."github.pub";
        ".ssh/gitlab".text           = home.ssh.gitlab;
        ".ssh/gitlab.pub".text       = home.ssh."gitlab.pub";

        ".gnupg/gpg-agent.conf".text = home.gnupg."gpg-agent.conf";
      };
    };
  };
}
