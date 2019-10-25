{ dirs, ... }:
self: super: {
  black_chocobo = super.libsForQt5.callPackage "${dirs.pkgs}/black_chocobo.nix" {};
}
