{ options, dirs, ... }:
{
  autoOptimiseStore = true;
  gc.automatic = true;
  optimise.automatic = true;
  useSandbox = false;
  allowedUsers = [ "@wheel" ];
  trustedUsers = [ "root" "@wheel" ];
  buildCores = 0;
  nixPath = [
    "nixpkgs=/home/nrd/git/nixpkgs"
    "nixos-config=${dirs.nixos}/configuration.nix"
    "nixpkgs-overlays=${dirs.nixos}/overlays-compat"
  ];
}
