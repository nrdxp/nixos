# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, pkgs, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./sys76-gazelle
  ];

  # specify device for other parts of configuration
  lib.device.name = "Gazelle";
  lib.device.screen = 1080;

  nix.maxJobs = mkDefault 4;

  environment.variables.LIBVA_DRIVER_NAME = "iHD";
  environment.variables.MESA_GL_VERSION_OVERRIDE = "4.5";
}
