{ pkgs, ... }:
{
  enable = true;
  s3tcSupport = true;

  # video acceleration
  extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    vaapiVdpau
    intel-ocl
    intel-media-driver
  ];
  extraPackages32 = with pkgs.pkgsi686Linux;
    [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
}
