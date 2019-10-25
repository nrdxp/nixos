{ dirs, ... }:
self: super: {
  dzvol = super.callPackage "${dirs.pkgs}/dzvol.nix" {};
}
