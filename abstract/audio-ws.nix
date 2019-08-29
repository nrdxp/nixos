{ pkgs, ... }:
{
  imports = [
    ./workstation.nix
    ../extern/musnix
  ];

  musnix = {
    enable = true;
    soundcardPciId = "00:1f.3";
    das_watchdog.enable = true;
    rtirq.enable = true;
  };

  environment.systemPackages = [ pkgs.ardour ];


  users.users.nrd.extraGroups = [ "audio" ];
}
