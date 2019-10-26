args@{ pkgs, usr, dirs, ... }:
let
  recImport = import ../lib/recImport.nix args;
in
recImport ./.
