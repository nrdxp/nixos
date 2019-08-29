{ pkgs, ... }:
{
  consoleLogLevel = 0;
  kernelPackages = pkgs.linuxPackages_latest;
  tmpOnTmpfs = true;
  kernel.sysctl."kernel.sysrq" = 1;
}
