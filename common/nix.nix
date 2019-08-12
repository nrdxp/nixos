{ options, ... }:
{
  autoOptimiseStore  = true;
  gc.automatic       = true;
  optimise.automatic = true;
  useSandbox         = false;
  allowedUsers       = [ "@wheel" ];
  buildCores         = 0;
  nixPath =
  [ "nixpkgs=https://releases.nixos.org/nixos/unstable/nixos-19.09pre188498.4557b9f1f50/nixexprs.tar.xz"
    "nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs-overlays=/etc/nixos/overlays-compat/"
  ];
}
