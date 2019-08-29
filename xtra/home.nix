{ lib, usr, ... }:
let
  inherit (usr) home;
  inherit (lib) mkForce;
in
{
  imports = [
    "${fetchGit https://github.com/rycee/home-manager}/nixos"
  ];

  home-manager.users.nrd = {
    home = {
      packages = mkForce [];

      file = {
        ".zshrc".text = "";

        ".config/git/config".text = home.gitconfig;

        ".ec2-keys".text = home.ec2-keys;

        ".ssh/config".text = home.ssh.config;
        ".ssh/github".text = home.ssh.github;
        ".ssh/github.pub".text = home.ssh."github.pub";
        ".ssh/gitlab".text = home.ssh.gitlab;
        ".ssh/gitlab.pub".text = home.ssh."gitlab.pub";

        ".gnupg/gpg-agent.conf".text = home.gnupg."gpg-agent.conf";
      };
    };
  };
}
