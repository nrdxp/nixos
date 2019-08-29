{ ... }:
{
  virtualisation.libvirtd.enable = true;
  users.extraUsers.nrd.extraGroups = [ "libvirtd" ];
  networking.firewall.checkReversePath = false;
}
