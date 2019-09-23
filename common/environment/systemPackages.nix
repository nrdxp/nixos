{ pkgs, usr, ... }:
let
  inherit (usr.tmux) plugins;

  sysPkgs = with pkgs; [
    fd
    git
    gnused
    htop
    lsof
    python
    ripgrep
    zsh-plugins
    zsh
    tig
    ncdu
    tokei
    pass
    file
    usbutils
    manpages
    gitAndTools.hub
    binutils
    bzip2
    gzip
    lzma
    p7zip
    unrar
    unzip
    go
    tmux
    bind
    neovim
    skim
    gnupg
    pciutils
  ];
in
sysPkgs ++ plugins
