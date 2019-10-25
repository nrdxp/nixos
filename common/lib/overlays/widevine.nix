{ dirs, ... }:
self: super:
{
  widevine = super.callPackage "${dirs.pkgs}/widevine.nix" {};
}
