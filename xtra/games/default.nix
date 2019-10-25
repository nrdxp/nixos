args@{ ... }:
let
  recImport = import ../../lib/recImport.nix args;
in
recImport ./.
