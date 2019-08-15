args@{ ... }:
let recImport = import ../../fn/recImport.nix args;
in
recImport ./.
