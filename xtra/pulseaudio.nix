{ pkgs, ... }:
{
  hardware.pulseaudio = {
  enable = true;
  package = pkgs.pulseaudioFull;
  daemon.logLevel = "error";
  systemWide = false;
  };
  environment.systemPackages = [ pkgs.pulsemixer ];
}
