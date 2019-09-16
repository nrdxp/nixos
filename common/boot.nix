{ pkgs, ... }:
{
  kernelPackages = pkgs.linuxPackages_latest;
  tmpOnTmpfs = true;
  kernel.sysctl."kernel.sysrq" = 1;
}
