{ options, ... }:
{
  autoOptimiseStore = true;
  gc.automatic = true;
  optimise.automatic = true;
  useSandbox = false;
  allowedUsers = [ "@wheel" ];
  trustedUsers = [ "@wheel" ];
  buildCores = 0;
  nixPath = [
    "nixpkgs=/home/nrd/git/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs-overlays=/etc/nixos/overlays-compat/"
  ];
}
