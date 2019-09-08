{ pkgs, ... }:
let
  inherit (pkgs.rustPlatform) rustcSrc;
in
{
  imports = [ ./home.nix ];
  environment = {
    systemPackages = with pkgs;
    [ rustc rustfmt cargo rls rustracer ];

    sessionVariables = {
      RUST_SRC_PATH = "${rustcSrc}";
    };
  };

  home-manager.users.nrd.home.file.".cargo/credentials".source = ./rust/cargo/credentials;
}
