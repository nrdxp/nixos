{ ... }:
self: super: {
  black_chocobo = super.libsForQt5.callPackage ./pkgs/black_chocobo.nix {};
}
