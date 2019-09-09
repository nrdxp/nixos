{ pkgs, usr, ... }:
let
  inherit (usr.tmux) plugins;

  sysPkgs = with pkgs; [
    bat
    exa
    fd
    git
    gnused
    htop
    lsof
    python
    ripgrep
    thefuck
    zsh-plugins
    zsh
    tig
    du-dust
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
    clang
    tmux
    bind
    xsel
    hlint
    neovim
    racer
    fzf
    skim
    gnupg
    pciutils
    ltrace
    valgrind
    gdb
  ];
in
sysPkgs ++ plugins
