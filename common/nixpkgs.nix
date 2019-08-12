{ config, lib, ... }:
with lib;
let usr = config.lib;
in
{ config =
  { allowUnfree = true;
  };
  overlays = attrsets.collect isFunction usr.overlays;

  pkgs = import <nixpkgs> {
    inherit (config.nixpkgs) config;
  };
}
