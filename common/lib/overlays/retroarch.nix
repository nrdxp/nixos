{ ... }:
self: super: {
  retroarchBare = super.retroarchBare.overrideAttrs (
    oldAttrs: rec {
      name = "retroarch-bare-${version}";
      version = "1.7.8.3";

      src = self.fetchFromGitHub {
        owner = "libretro";
        repo = "RetroArch";
        sha256 = "0lsfiljy6cin3xsxyh80d6y9a77h7h82fcm6k148cd8mndvyxcdn";
        rev = "v${version}";
      };

      NIX_CFLAGS_COMPILE = "-march=native -flto";
      NIX_CXXFLAGS_COMPILE = "-march=native -flto";
      # add mesa_noglu to build inputs for kms support
      buildInputs = let
        inherit (super) retroarchBare mesa_noglu wayland;
      in
        retroarchBare.buildInputs ++ [ mesa_noglu wayland ];
    }
  );
}
