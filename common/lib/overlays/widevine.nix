{ ... }:
self: super:
{
  widevine = super.callPackage ../../../pkgs/widevine.nix {};
}
