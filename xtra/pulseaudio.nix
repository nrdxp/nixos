{ ... }:
{
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.daemon.logLevel = "error";
  hardware.pulseaudio.systemWide = false;
  environment.systemPackages = [ pkgs.pulsemixser ];
}
