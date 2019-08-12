{ ... }:
self: super:
{
  zsh-plugins = super.callPackage ./pkgs/zsh-plugins.nix {};
}
