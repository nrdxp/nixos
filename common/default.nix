args@{ pkgs, usr, ... }:
let
  recImport = import ../fn/recImport.nix args;
in
recImport ./.
