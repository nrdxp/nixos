# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  lib.devices.device = "sys76-gazelle";

  hardware.cpu.intel.updateMicrocode = true;

  hardware.opengl.s3tcSupport = true;

  hardware.opengl.enable = true;

  hardware.bluetooth.enable = true;

  services.xserver.videoDrivers = [ "intel" "modesetting" ];

  security.polkit.extraConfig =
  ''
  polkit.addRule(function(a, s) {
    if (a.id = 'xf86-video-intel-backlight-helper' && s.isInGroup('users'))
      return polkit.Result.YES;
  });
  '';

  # enable tearfree
  services.xserver.extraConfig =
  ''
  Section "OutputClass"
    Identifier "Intel Graphics"
    MatchDriver "i915"
    Driver "intel"
    Option "TearFree" "true"
  EndSection
  '';

  # hardware acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl.extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau intel-ocl intel-media-driver ];
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];

  # boot specific info for this laptop
  boot.initrd.availableKernelModules = [ "ahci" "nvme" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

	boot.loader.efi.efiSysMountPoint = "/boot/efi";
	boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/880d08c9-f653-4be0-b4c1-662877d77a9e";
      fsType = "xfs";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/FAC0-3221";
      fsType = "vfat";
    };

  nix.maxJobs = lib.mkDefault 4;

  environment.variables.LIBVA_DRIVER_NAME="iHD";
  environment.variables.MESA_GL_VERSION_OVERRIDE="4.5";
}
