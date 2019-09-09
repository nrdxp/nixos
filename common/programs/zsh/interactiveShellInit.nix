{ pkgs, usr, ... }:
let
  inherit (pkgs) skim zsh-plugins;
  inherit (usr.zsh) startrc endrc;
  inherit (builtins) concatStringsSep;
in
concatStringsSep "\n\n" [
  startrc
  "source ${skim}/share/skim/completion.zsh"
  "source ${zsh-plugins}/plugins.sh\n"
  endrc
  "source ${skim}/share/skim/key-bindings.zsh"
]
