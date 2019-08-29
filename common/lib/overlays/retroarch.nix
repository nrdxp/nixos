{ ... }:
self: super: {
  retroarchBare = super.retroarchBare.overrideAttrs (
    oldAttrs: rec {
      name = "retroarch-bare-${version}";
      version = "1.7.7";

      src = self.fetchFromGitHub {
        owner = "libretro";
        repo = "RetroArch";
        sha256 = "026720z0vpiwr4da7l2x2yinns09fmg6yxsib203xwnixj399azi";
        rev = "v${version}";
      };

      NIX_CFLAGS_COMPILE = "-march=native -flto";
      NIX_CXXFLAGS_COMPILE = "-march=native -flto";
      # add mesa_noglu to build inputs for kms support
      buildInputs = let
        inherit (super) retroarchBare mesa_noglu;
      in
        retroarchBare.buildInputs ++ [ mesa_noglu ];
    }
  );
}
