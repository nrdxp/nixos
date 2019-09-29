{ lib, usr, ... }:
let
  inherit (usr) tmux packages;

  sysPkgs = flattenAttrs packages;

  flattenAttrs = import ../../fn/flattenAttrs.nix { inherit lib; };
in
sysPkgs ++ tmux.plugins
