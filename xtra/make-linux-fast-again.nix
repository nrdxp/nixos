# file: make-linux-fast-again.nix
{ pkgs, config, ... }:
let
  inherit (builtins) readFile fetchurl;
  cmdline = readFile (
    fetchurl "https://make-linux-fast-again.com"
  );
in
{ boot.kernelParams = pkgs.lib.splitString " " cmdline; }
