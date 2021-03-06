{ pkgs, ... }:
let
  inherit (pkgs) lm_sensors wirelesstools;
in
{
  environment.systemPackages = [ lm_sensors wirelesstools ];

  # to enable brightness keys 'keys' value may need updating per device
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [ 225 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -A 5";
      }
      {
        keys = [ 224 ];
        events = [ "key" ];
        command = "/run/current-system/sw/bin/light -U 5";
      }
    ];
  };

  sound.mediaKeys = {
    enable = true;
    volumeStep = "1dB";
  };

  # better timesync for unstable internet connections
  services.chrony.enable = true;
  services.timesyncd.enable = false;

  # power management features
  services.tlp.enable = true;
  services.logind.lidSwitch = "suspend";

  nixpkgs.overlays = let
    light_ov = self: super: {
      light = super.light.overrideAttrs (
        o: {
          src = self.fetchFromGitHub {
            owner = "haikarainen";
            repo = "light";
            rev = "ae7a6ebb45a712e5293c7961eed8cceaa4ebf0b6";
            sha256 = "00z9bxrkjpfmfhz9fbf6mjbfqvixx6857mvgmiv01fvvs0lr371n";
          };
        }
      );
    };
  in
    [ light_ov ];
}
