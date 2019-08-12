{ ... }:
self: super:
{
  default-cursor = super.callPackage ./pkgs/cursor.nix {};
}
