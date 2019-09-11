{ pkgs, ... }:
let
  inherit (pkgs) clang;
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  inherit (pkgs.latest.rustChannels.stable) cargo rust rust-src;
in
{
  imports = [ ./home.nix ];
  environment = {
    systemPackages =
      [ (rust.override {
          extensions = [
            "rust-src"
            "rls-preview"
            "rust-analysis"
            "rustfmt-preview"
            "clippy-preview"
          ];
          targets = [
            "wasm32-unknown-unknown"
            "wasm32-unknown-emscripten"
            "asmjs-unknown-emscripten"
          ];
        })
        cargo
        clang
      ];
  };

  home-manager.users.nrd.home.file.".cargo/credentials".source = ./rust/cargo/credentials;

  nixpkgs.overlays = [ moz_overlay ];
}
