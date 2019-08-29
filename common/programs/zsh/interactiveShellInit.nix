{ pkgs, usr, ... }:
let
  inherit (pkgs) fzf zsh-plugins;
  inherit (usr.zsh) startrc endrc;
  inherit (builtins) concatStringsSep;
in
concatStringsSep "\n\n" [
  startrc
  "source ${zsh-plugins}/plugins.sh\n"
  endrc
  "source ${fzf}/share/fzf/key-bindings.zsh"
]
