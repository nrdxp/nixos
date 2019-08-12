{ pkgs, usr, ... }:
with pkgs; let
  tmuxPkgs = usr.tmux.plugins;
  sysPkgs =
  [ bat      exa         fd
    git      gnused      htop
    lsof     python      ripgrep
    thefuck  zsh-plugins zsh
    tig      du-dust     ncdu
    tokei    pass        file
    usbutils manpages    gitAndTools.hub
    binutils bzip2       gzip
    lzma     p7zip       unrar
    unzip    go          clang
    tmux     bind        xsel
    hlint    neovim      racer
    fzf      gnupg       pciutils
  ];
in sysPkgs ++ tmuxPkgs
