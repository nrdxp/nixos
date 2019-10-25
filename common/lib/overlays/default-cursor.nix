{ dirs, ... }:
self: super: {
  default-cursor = super.callPackage "${dirs.pkgs}/cursor.nix" {};
}
