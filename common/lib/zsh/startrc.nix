{ pkgs, ... }:
let
  inherit (pkgs.gitAndTools) hub;
in
''
  # set colorscheme
  [[ -f $HOME/.base16_theme ]] && source $HOME/.base16_theme

  #namespace to hide stdout
  {

  hash -d \
    nixos=/etc/nixos \
    dl=~/Downloads \
    git=~/git

  hash -d nixpkgs=~git/nixpkgs

  # hub setup
  eval $(${hub}/bin/hub alias -s)

  # Zsh options
  setopt extendedglob
  setopt incappendhistory
  setopt sharehistory
  setopt histignoredups
  setopt histreduceblanks
  setopt histignorespace
  setopt histallowclobber
  setopt autocd
  setopt cdablevars
  setopt nomultios
  setopt pushdignoredups
  setopt autocontinue
  setopt promptsubst

  # Environment
  HISTSIZE=10000
  SAVEHIST=10000
  HISTFILE=$HOME/.history
  DIRSTACKSIZE=5

  # user defined functions
  if [[ -d $HOME/.zfunctions ]]; then
    typeset -U fpath
    fpath=($HOME/.zfunctions $fpath)

    for file in $HOME/.zfunctions/*; do
      autoload -Uz $file
    done
  fi

  # source local config not synced to git repo
  if [[ -f $HOME/.zshlocal ]]; then
  . $HOME/.zshlocal
  fi

  # create local zshrc if it does not exist
  [[ -f $HOME/.zshrc ]] \
    || printf "#" > $HOME/.zshrc
''
