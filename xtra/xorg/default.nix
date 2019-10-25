args@{ pkgs, usr, ... }:
let
  recImport = import ../../lib/recImport.nix args;
in
recImport ./.
