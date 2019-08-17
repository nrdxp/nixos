{ ... }:
{
  # boot specific info for this laptop
  kernelModules = [ "kvm-intel" ];
  initrd.kernelModules = [ "i915" ];
  initrd.availableKernelModules = [ "ahci" "nvme" "rtsx_pci_sdmmc" ];

	loader.efi.efiSysMountPoint = "/boot/efi";
	loader.efi.canTouchEfiVariables = true;

  loader.systemd-boot.enable = true;
  loader.systemd-boot.editor = false;
}
