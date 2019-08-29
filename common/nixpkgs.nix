{ config, lib, ... }:
let
  inherit (lib) attrsets isFunction;
  inherit (attrsets) collect;
  inherit (config.lib) overlays;
in
{
  config = {
    allowUnfree = true;
  };
  overlays = collect isFunction overlays;

  # so overlays will be available to all system tools
  pkgs = import <nixpkgs> {
    inherit (config.nixpkgs) config;
  };
}
