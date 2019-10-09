{ ... }:
self: super: {
  retroarchBare = super.retroarchBare.overrideAttrs (
    oldAttrs: rec {
      name = "retroarch-bare-${version}";
      version = "1.7.9.2";

      src = self.fetchFromGitHub {
        owner = "libretro";
        repo = "RetroArch";
        sha256 = "14kay5g9rnm79mly7b4x5jwkidjaki8qqkpf21hnj1r2z1q7bp5b";
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
