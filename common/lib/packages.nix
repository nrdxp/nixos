{ pkgs, ... }:
with pkgs;
{
  applications = {
    editors = [ neovim ];
    version-management = [ git git-crypt gitAndTools.hub tig ];
    misc = [ zathura ];
  };

  data = {
    documentation = [ manpages ];
  };

  development = {
    compilers = [ go ];
    interpreters = [ python ];
    tools = {
      analysis = [ bingrep ];
      misc = [ lsof binutils ];
    };
  };

  shells = [ zsh zsh-plugins ];

  tools = {
    admin = [ procs ];
    compression = [ bzip2 gzip xz lrzip ];
    nix = [ nixpkgs-fmt ];
    package-management = [ nix ];
    security = [ gnupg pass ];

    text = [
      diffutils
      gawk
      gnugrep
      gnused
      ripgrep
    ];

    misc = [
      bat
      direnv
      du-dust
      fd
      file
      lsd
      ncdu
      skim
      tmux
      tokei
    ];

    networking = [ curl wget ];
    system = [ htop pciutils ];
  };

  servers.dns = [ bind dnsutils ];

  os-specific = {
    linux = [ firejail systemd usbutils utillinux ];
  };
}
