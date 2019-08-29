args@{ pkgs, ... }:
let
  recImport = import ../../fn/recImport.nix args;
in
recImport ./.
