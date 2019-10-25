{ lib, usr, ... }:
let
  inherit (usr) tmux packages;

  sysPkgs = flattenAttrs packages;

  flattenAttrs = import ../../lib/flattenAttrs.nix { inherit lib; };
in
sysPkgs ++ tmux.plugins
